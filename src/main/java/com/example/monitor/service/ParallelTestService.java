package com.example.monitor.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.monitor.config.MetricsConfig.CustomMetrics;
import com.example.monitor.model.ConfigurationTests;
import com.example.monitor.model.ResultatsTests;
import com.example.monitor.repository.ConfigurationTestsRepository;
import com.example.monitor.repository.ResultatsTestsRepository;

import io.micrometer.core.instrument.Timer;

@Service
@Transactional
public class ParallelTestService {
	private static final Logger logger = LoggerFactory.getLogger(ParallelTestService.class);

	private final TestService testService;
	private final ConfigurationTestsRepository configTestsRepository;
	private final ResultatsTestsRepository resultatsTestsRepository;
	private final CustomMetrics metrics;
	private final Timer testTimer;

	public ParallelTestService(TestService testService, ConfigurationTestsRepository configTestsRepository,
			ResultatsTestsRepository resultatsTestsRepository, CustomMetrics metrics, Timer testTimer) {
		this.testService = testService;
		this.configTestsRepository = configTestsRepository;
		this.resultatsTestsRepository = resultatsTestsRepository;
		this.metrics = metrics;
		this.testTimer = testTimer;
	}

	@Async("testExecutor")
	public CompletableFuture<TestResultService> executeTestAsync(ConfigurationTests config) {
		metrics.incrementActiveThreads();
		metrics.incrementPendingTests();

		long startTime = System.currentTimeMillis();

		try {
			// CORRECTION : Utilisation correcte du Timer avec Callable
			TestResultService result = testTimer.recordCallable(() -> testService.executeSingleTest(config));

			// Sauvegarde du résultat
			ResultatsTests resultat = new ResultatsTests();
			resultat.setConfigTest(config);
			resultat.setSucces(result.isSuccess());
			resultat.setTempsReponse(result.getResponseTime());
			resultat.setCodeStatut(result.getStatusCode());
			resultat.setMessage(result.getMessage());
			resultat.setDateExecution(LocalDateTime.now());

			resultatsTestsRepository.save(resultat);

			metrics.recordTestResult(result.isSuccess(), System.currentTimeMillis() - startTime);

			logger.debug("Test {} exécuté avec succès: {}", config.getId(), result.isSuccess());
			return CompletableFuture.completedFuture(result);

		} catch (Exception e) {
			logger.error("Erreur lors de l'exécution asynchrone du test", e);
			metrics.recordTestResult(false, System.currentTimeMillis() - startTime);

			// Sauvegarde de l'échec
			ResultatsTests resultat = new ResultatsTests();
			resultat.setConfigTest(config);
			resultat.setSucces(false);
			resultat.setMessage("Erreur d'exécution: " + e.getMessage());
			resultat.setDateExecution(LocalDateTime.now());
			resultatsTestsRepository.save(resultat);

			return CompletableFuture.completedFuture(TestResultService.failure(config, e.getMessage()));
		} finally {
			metrics.decrementActiveThreads();
		}
	}

	public int getActiveTestCount() {
		return metrics.getActiveThreads();
	}

	public long getPendingTestCount() {
		return metrics.getPendingTests();
	}

	public CompletableFuture<Void> executeBatchTests(List<ConfigurationTests> configs) {
		logger.info("Début de l'exécution de batch de {} tests", configs.size());

		List<CompletableFuture<TestResultService>> futures = configs.stream().map(this::executeTestAsync)
				.collect(Collectors.toList());

		return CompletableFuture.allOf(futures.toArray(new CompletableFuture[0])).whenComplete((result, throwable) -> {
			if (throwable != null) {
				logger.error("Erreur lors de l'exécution du batch de tests", throwable);
			} else {
				logger.info("Batch de {} tests exécuté avec succès", configs.size());
			}
		});
	}

	public void executeAllActiveTests() {
		List<ConfigurationTests> activeConfigs = configTestsRepository.findByActifTrue();
		logger.info("Exécution de tous les tests actifs: {} configurations", activeConfigs.size());

		executeBatchTests(activeConfigs);
	}
}