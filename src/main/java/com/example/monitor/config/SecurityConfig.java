package com.example.monitor.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
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
				// === PAGES PUBLIQUES ===
				.requestMatchers("/", "/login", "/static/**", "/css/**", "/js/**", "/images/**", "/webjars/**",
						"/error", "/favicon.ico", "/manifest.json", "/api/test/**", "/api/urgence/**", "/api/debug/**")
				.permitAll()

				// === DASHBOARD ===
				.requestMatchers("/dashboard").authenticated()

				// Monitoring public
				.requestMatchers("/monitoring/health", "/monitoring/prometheus", "/monitoring/info").permitAll()

				// === NOUVELLE RÈGLE - GESTION DES UTILISATEURS ===
				.requestMatchers("/admin/users/**").hasAnyRole("SUPER_ADMIN", "SUPERVISEUR")

				// Règles spécifiques
				.requestMatchers("/tests/lancer-categorie/**", "/tests/lancer-tous")
				.hasAnyRole("SUPERVISEUR", "TECHNICIEN", "OPERATEUR").requestMatchers("/api/audit/page")
				.hasAnyRole("ADMIN", "SUPERVISEUR")

				// Accès par rôle
				.requestMatchers("/monitoring/**").hasAnyRole("SUPERVISEUR", "TECHNICIEN")
				.requestMatchers("/api/tests/execute/**").hasAnyRole("SUPERVISEUR", "OPERATEUR", "TECHNICIEN")
				.requestMatchers("/api/config/**", "/tests/**").hasAnyRole("SUPERVISEUR", "TECHNICIEN", "OPERATEUR")
				.requestMatchers("/admin/**", "/users/**").hasRole("SUPERVISEUR")
				.requestMatchers("/caisses/**", "/rapports/**").authenticated()

				// Tout le reste nécessite une authentification
				.anyRequest().authenticated())

				.formLogin(form -> form.loginPage("/login").loginProcessingUrl("/login")
						.defaultSuccessUrl("/dashboard", true).failureUrl("/login?error=true")
						.usernameParameter("username").passwordParameter("password").permitAll())

				.logout(logout -> logout.logoutUrl("/logout").logoutSuccessUrl("/login?logout=true")
						.invalidateHttpSession(true).clearAuthentication(true).deleteCookies("JSESSIONID").permitAll())

				.exceptionHandling(exception -> exception.accessDeniedPage("/access-denied"))

				.httpBasic(Customizer.withDefaults())

				// === CORRECTION IMPORTANTE : Ajouter /tests/** à la liste CSRF ===
				.csrf(csrf -> csrf.ignoringRequestMatchers("/api/**", "/monitoring/**", "/h2-console/**",
						"/tests/lancer-tous", // Ajouté
						"/tests/lancer-categorie/**" // Ajouté
				))

				.headers(headers -> headers.frameOptions(frameOptions -> frameOptions.sameOrigin()));

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