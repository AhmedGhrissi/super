// src/main/java/com/example/monitor/exception/BusinessException.java
package com.example.monitor.exception;

public class BusinessException extends RuntimeException {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	private final String code;
	private final String details;

	public BusinessException(String code, String message) {
		super(message);
		this.code = code;
		this.details = null;
	}

	public BusinessException(String code, String message, String details) {
		super(message);
		this.code = code;
		this.details = details;
	}

	public String getCode() {
		return code;
	}

	public String getDetails() {
		return details;
	}
}