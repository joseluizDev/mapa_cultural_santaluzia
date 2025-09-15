/// Base exception class following Object Calisthenics
/// Encapsulates error information in a single object
abstract class AppException implements Exception {
  final String message;
  final String code;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    required this.code,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}

/// Repository layer exceptions
class RepositoryException extends AppException {
  const RepositoryException({
    required super.message,
    required super.code,
    super.stackTrace,
  });

  factory RepositoryException.dataNotFound(String entity) {
    return RepositoryException(
      message: '$entity not found in repository',
      code: 'DATA_NOT_FOUND',
    );
  }

  factory RepositoryException.dataCorrupted(String details) {
    return RepositoryException(
      message: 'Data corruption detected: $details',
      code: 'DATA_CORRUPTED',
    );
  }

  factory RepositoryException.accessDenied() {
    return const RepositoryException(
      message: 'Access denied to repository data',
      code: 'ACCESS_DENIED',
    );
  }
}

/// Service layer exceptions
class ServiceException extends AppException {
  const ServiceException({
    required super.message,
    required super.code,
    super.stackTrace,
  });

  factory ServiceException.operationFailed(String operation) {
    return ServiceException(
      message: 'Service operation failed: $operation',
      code: 'OPERATION_FAILED',
    );
  }

  factory ServiceException.validationFailed(String details) {
    return ServiceException(
      message: 'Validation failed: $details',
      code: 'VALIDATION_FAILED',
    );
  }

  factory ServiceException.configurationError() {
    return const ServiceException(
      message: 'Service configuration error',
      code: 'CONFIGURATION_ERROR',
    );
  }
}

/// Use case layer exceptions
class UseCaseException extends AppException {
  const UseCaseException({
    required super.message,
    required super.code,
    super.stackTrace,
  });

  factory UseCaseException.businessRuleViolation(String rule) {
    return UseCaseException(
      message: 'Business rule violation: $rule',
      code: 'BUSINESS_RULE_VIOLATION',
    );
  }

  factory UseCaseException.invalidInput(String field) {
    return UseCaseException(
      message: 'Invalid input for field: $field',
      code: 'INVALID_INPUT',
    );
  }
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    required super.code,
    super.stackTrace,
  });

  factory NetworkException.connectionTimeout() {
    return const NetworkException(
      message: 'Connection timeout',
      code: 'CONNECTION_TIMEOUT',
    );
  }

  factory NetworkException.noInternetConnection() {
    return const NetworkException(
      message: 'No internet connection available',
      code: 'NO_INTERNET',
    );
  }

  factory NetworkException.serverError(int statusCode) {
    return NetworkException(
      message: 'Server error with status code: $statusCode',
      code: 'SERVER_ERROR',
    );
  }
}

/// Authentication exceptions
class AuthException extends AppException {
  const AuthException({
    required super.message,
    required super.code,
    super.stackTrace,
  });

  factory AuthException.userNotAuthenticated() {
    return const AuthException(
      message: 'User is not authenticated',
      code: 'NOT_AUTHENTICATED',
    );
  }

  factory AuthException.invalidCredentials() {
    return const AuthException(
      message: 'Invalid user credentials',
      code: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthException.tokenExpired() {
    return const AuthException(
      message: 'Authentication token has expired',
      code: 'TOKEN_EXPIRED',
    );
  }
}
