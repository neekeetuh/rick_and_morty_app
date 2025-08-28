part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class UserAuthorized extends AuthState {
  final AppUser user;

  UserAuthorized({required this.user});
}

final class UserUnauthorized extends AuthState {}

final class AuthErrorState extends AuthState {
  final AuthException exception;
  final String errorMessage;

  AuthErrorState({required this.exception, required this.errorMessage});
}
