package com.example.monitor.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CustomErrorController implements ErrorController {

	@RequestMapping("/error")
	public ResponseEntity<Map<String, Object>> handleError(HttpServletRequest request) {
		Map<String, Object> errorDetails = new HashMap<>();

		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		Object message = request.getAttribute(RequestDispatcher.ERROR_MESSAGE);

		if (status != null) {
			int statusCode = Integer.parseInt(status.toString());
			errorDetails.put("status", statusCode);
			errorDetails.put("error", HttpStatus.valueOf(statusCode).getReasonPhrase());
		}

		if (message != null) {
			errorDetails.put("message", message.toString());
		} else {
			errorDetails.put("message", "Une erreur est survenue");
		}

		errorDetails.put("path", request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI));

		return new ResponseEntity<>(errorDetails, HttpStatus.INTERNAL_SERVER_ERROR);
	}
}