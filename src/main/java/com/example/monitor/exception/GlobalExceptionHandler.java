//package com.example.monitor.exception;
//
//import java.net.URLEncoder;
//import java.nio.charset.StandardCharsets;
//import java.time.LocalDateTime;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//import org.springframework.web.bind.annotation.RestControllerAdvice;
//import org.springframework.web.servlet.resource.NoResourceFoundException;
//
//import jakarta.servlet.http.HttpServletRequest;
//
//@RestControllerAdvice
//public class GlobalExceptionHandler {
//
//	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
//
//	@ExceptionHandler(BusinessException.class)
//	public ResponseEntity<ApiError> handleBusinessException(BusinessException ex, HttpServletRequest request) {
//		logger.warn("Exception métier: {} - {}", ex.getCode(), ex.getMessage());
//
//		ApiError error = new ApiError(HttpStatus.BAD_REQUEST.value(), ex.getCode(), ex.getMessage(),
//				request.getRequestURI(), ex.getDetails() != null ? List.of(ex.getDetails()) : null);
//
//		return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
//	}
//
//	@ExceptionHandler(ServeurNotFoundException.class)
//	public ResponseEntity<ApiError> handleServeurNotFound(ServeurNotFoundException ex, HttpServletRequest request) {
//		logger.warn("Serveur non trouvé: {}", ex.getMessage());
//
//		ApiError error = new ApiError(HttpStatus.NOT_FOUND.value(), ex.getCode(), ex.getMessage(),
//				request.getRequestURI());
//
//		return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
//	}
//
//	@ExceptionHandler(Exception.class)
//	public Object handleGenericException(Exception ex, HttpServletRequest request) {
//		logger.error("Erreur interne du serveur: ", ex);
//
//		// Vérifie si c'est une requête API
//		if (isApiRequest(request)) {
//			// Pour les APIs, retourne du JSON
//			ApiError error = new ApiError(HttpStatus.INTERNAL_SERVER_ERROR.value(), "INTERNAL_ERROR",
//					"Une erreur interne est survenue", request.getRequestURI());
//			return new ResponseEntity<>(error, HttpStatus.INTERNAL_SERVER_ERROR);
//		} else {
//			// Pour les pages HTML, redirige vers la page d'erreur
//			try {
//				String encodedMessage = URLEncoder.encode(ex.getMessage(), StandardCharsets.UTF_8);
//				return "redirect:/error-page?message=" + encodedMessage;
//			} catch (Exception e) {
//				// Fallback en cas d'erreur d'encodage
//				return "redirect:/error-page?message=Une+erreur+est+survenue";
//			}
//		}
//	}
//
//	private boolean isApiRequest(HttpServletRequest request) {
//		String uri = request.getRequestURI();
//		String acceptHeader = request.getHeader("Accept");
//
//		return uri.startsWith("/api/") || "XMLHttpRequest".equals(request.getHeader("X-Requested-With"))
//				|| (acceptHeader != null && acceptHeader.contains("application/json"));
//	}
//
//	@ExceptionHandler(NoResourceFoundException.class)
//	public ResponseEntity<Map<String, String>> handleNoResourceFoundException(NoResourceFoundException ex) {
//		logger.debug("Resource not found: {}", ex.getResourcePath());
//
//		// Ignorer silencieusement les erreurs Chrome DevTools
//		if (ex.getResourcePath() != null && ex.getResourcePath().contains("chrome.devtools")) {
//			return ResponseEntity.notFound().build();
//		}
//
//		Map<String, String> errorResponse = new HashMap<>();
//		errorResponse.put("error", "Resource not found");
//		errorResponse.put("path", ex.getResourcePath());
//		errorResponse.put("timestamp", LocalDateTime.now().toString());
//
//		return ResponseEntity.status(HttpStatus.NOT_FOUND).body(errorResponse);
//	}
//
//	// Classe DTO pour les erreurs API
//	public static class ApiError {
//		private final LocalDateTime timestamp;
//		private final int status;
//		private final String code;
//		private final String message;
//		private final String path;
//		private final List<String> details;
//
//		public ApiError(int status, String code, String message, String path, List<String> details) {
//			this.timestamp = LocalDateTime.now();
//			this.status = status;
//			this.code = code;
//			this.message = message;
//			this.path = path;
//			this.details = details;
//		}
//
//		public ApiError(int status, String code, String message, String path) {
//			this(status, code, message, path, null);
//		}
//
//		// Getters
//		public LocalDateTime getTimestamp() {
//			return timestamp;
//		}
//
//		public int getStatus() {
//			return status;
//		}
//
//		public String getCode() {
//			return code;
//		}
//
//		public String getMessage() {
//			return message;
//		}
//
//		public String getPath() {
//			return path;
//		}
//
//		public List<String> getDetails() {
//			return details;
//		}
//	}
//}