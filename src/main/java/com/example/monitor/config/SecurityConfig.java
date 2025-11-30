package com.example.monitor.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http.authorizeHttpRequests(authz -> authz
				// Pages publiques
				.requestMatchers("/", "/login", "/static/**", "/webjars/**", "/error", "/api/test/**",
						"/api/urgence/**", "/api/debug/**")
				.permitAll()
				// Monitoring public
				.requestMatchers("/monitoring/health", "/monitoring/prometheus", "/monitoring/info").permitAll()

				// === NOUVELLE RÈGLE - GESTION DES UTILISATEURS ===
				.requestMatchers("/admin/users/**").hasAnyRole("SUPER_ADMIN", "SUPERVISEUR")

				// Règles spécifiques
				.requestMatchers("/tests/lancer-categorie/**").hasAnyRole("SUPERVISEUR", "TECHNICIEN", "OPERATEUR")
				.requestMatchers("/api/audit/page").hasAnyRole("ADMIN", "SUPERVISEUR")

				// Accès par rôle
				.requestMatchers("/monitoring/**").hasAnyRole("SUPERVISEUR", "TECHNICIEN")
				.requestMatchers("/api/tests/execute/**").hasAnyRole("SUPERVISEUR", "OPERATEUR", "TECHNICIEN")
				.requestMatchers("/api/config/**", "/tests/**").hasAnyRole("SUPERVISEUR", "TECHNICIEN", "OPERATEUR")
				.requestMatchers("/admin/**", "/users/**").hasRole("SUPERVISEUR")
				.requestMatchers("/caisses/**", "/rapports/**", "/dashboard").authenticated().anyRequest()
				.authenticated() // ⚠️ CETTE LIGNE DOIT ÊTRE COMME ÇA

		).formLogin(form -> form.loginPage("/login").loginProcessingUrl("/login")
				.successHandler(authenticationSuccessHandler()).failureUrl("/login?error=true").permitAll())
				.httpBasic(Customizer.withDefaults()).csrf(AbstractHttpConfigurer::disable);

		return http.build();
	}

	@Bean
	public AuthenticationSuccessHandler authenticationSuccessHandler() {
		return (request, response, authentication) -> {
			String targetUrl = "/dashboard";

			if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_CONSULTANT"))) {
				targetUrl = "/rapports";
			} else if (authentication.getAuthorities().stream()
					.anyMatch(a -> a.getAuthority().equals("ROLE_OPERATEUR"))) {
				targetUrl = "/tests";
			}

			response.sendRedirect(targetUrl);
		};
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder(12);
	}
}