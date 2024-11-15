package com.rapifuzz.assign.exception;

public class ResourceNotFoundException extends RuntimeException {
    
    // Constructor with message
    public ResourceNotFoundException(String message) {
        super(message);
    }

    // Constructor with message and cause
    public ResourceNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}
