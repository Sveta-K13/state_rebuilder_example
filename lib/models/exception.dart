class NullNameException extends Error {}

class ValidationException extends Error {
  String message;
  ValidationException(
    this.message,
  );
}
