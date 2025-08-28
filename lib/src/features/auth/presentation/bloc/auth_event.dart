part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

class InitUser extends AuthEvent {
  const InitUser();
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;

  const LoginUser({required this.email, required this.password});
}

class SignUpUser extends AuthEvent {
  final String email;
  final String password;
  final String repeatedPassword;

  const SignUpUser(
      {required this.email,
      required this.password,
      required this.repeatedPassword});
}

class SignOutUser extends AuthEvent {
  const SignOutUser();
}
