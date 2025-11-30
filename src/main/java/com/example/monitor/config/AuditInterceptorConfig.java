package com.example.monitor.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.monitor.service.AuditService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class AuditInterceptorConfig implements HandlerInterceptor {

	@Autowired
	private AuditService auditService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		// On enregistre le temps de début pour mesurer la durée d'exécution
		if (handler instanceof HandlerMethod) {
			request.setAttribute("startTime", System.currentTimeMillis());
		}
		return true;
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {

		if (handler instanceof HandlerMethod) {
			Long startTime = (Long) request.getAttribute("startTime");
			if (startTime != null) {
				long executionTime = System.currentTimeMillis() - startTime;
				logRequest(request, response, executionTime, ex);
			}
		}
	}

	private void logRequest(HttpServletRequest request, HttpServletResponse response, long executionTime,
			Exception ex) {

		String method = request.getMethod();
		String uri = request.getRequestURI();
		int status = response.getStatus();

		// Détermine l'action et la ressource basée sur l'URL
		String action = getActionFromMethod(method);
		String resource = getResourceFromUri(uri);
		String resourceId = extractResourceId(uri);

		boolean success = (ex == null && status < 400);
		String description = method + " " + uri + " (" + status + ")";

		if (success) {
			auditService.logActionWithExecutionTime(action, resource, resourceId, description, executionTime);
		} else {
			String errorMessage = ex != null ? ex.getMessage() : "HTTP " + status;
			auditService.logError(action, resource, resourceId, description, errorMessage);
		}
	}

	private String getActionFromMethod(String method) {
		switch (method) {
		case "GET":
			return "READ";
		case "POST":
			return "CREATE";
		case "PUT":
			return "UPDATE";
		case "DELETE":
			return "DELETE";
		default:
			return "EXECUTE";
		}
	}

	private String getResourceFromUri(String uri) {
		if (uri.contains("/serveurs")) {
			return "SERVEUR";
		}
		if (uri.contains("/tests")) {
			return "TEST";
		}
		if (uri.contains("/caisses")) {
			return "CAISSE";
		}
		if (uri.contains("/users")) {
			return "USER";
		}
		return "SYSTEM";
	}

	private String extractResourceId(String uri) {
		// Extrait l'ID de l'URL (ex: /serveurs/123 → "123")
		String[] parts = uri.split("/");
		for (int i = parts.length - 1; i >= 0; i--) {
			if (!parts[i].isEmpty() && !parts[i].contains(".")) {
				try {
					Long.parseLong(parts[i]);
					return parts[i];
				} catch (NumberFormatException e) {
					// Ce n'est pas un nombre, on continue
				}
			}
		}
		return "N/A";
	}
}