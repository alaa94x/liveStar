/// Base exception class for app-specific errors
abstract class AppException implements Exception {
  final String message;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException(
    this.message, {
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => message;
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

class ConnectionException extends NetworkException {
  const ConnectionException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

class TimeoutException extends NetworkException {
  const TimeoutException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

/// Data-related exceptions
class DataException extends AppException {
  const DataException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

class NotFoundException extends DataException {
  const NotFoundException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

class ValidationException extends DataException {
  const ValidationException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

/// Authentication-related exceptions
class AuthenticationException extends AppException {
  const AuthenticationException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

class AuthorizationException extends AppException {
  const AuthorizationException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

/// Permission-related exceptions
class PermissionException extends AppException {
  const PermissionException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

/// Storage-related exceptions
class StorageException extends AppException {
  const StorageException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

/// Unknown/Generic exceptions
class UnknownException extends AppException {
  const UnknownException(
    super.message, {
    super.originalError,
    super.stackTrace,
  });
}

