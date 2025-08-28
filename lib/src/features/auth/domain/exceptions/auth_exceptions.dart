sealed class AuthException implements Exception {}

class UserNotFoundException extends AuthException {}

class WrongPasswordException extends AuthException {}

class EmailIsAlreadyUsedException extends AuthException {}

class PasswordAndRepeatedPasswordAreNotEqualException extends AuthException {}

class UnknownAuthException extends AuthException {}
