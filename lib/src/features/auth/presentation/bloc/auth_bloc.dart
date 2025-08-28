import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty_app/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:rick_and_morty_app/src/features/auth/domain/models/app_user.dart';
import 'package:rick_and_morty_app/src/features/auth/domain/repositories/auth_repository_interface.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _repository;

  AuthBloc({required IAuthRepository repository})
      : _repository = repository,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case InitUser():
          await _onInitUser(event, emit);
        case LoginUser():
          await _onLoginUser(event, emit);
        case SignUpUser():
          await _onSignUpUser(event, emit);
        case SignOutUser():
          await _onSignOutUser(event, emit);
      }
    });
    add(const InitUser());
  }

  Future<void> _onLoginUser(LoginUser event, Emitter<AuthState> emit) async {
    try {
      await _repository.login(event.email, event.password);
      emit(UserAuthorized(user: _repository.currentUser!));
    } on AuthException catch (e) {
      switch (e) {
        case UserNotFoundException():
          emit(AuthErrorState(
              exception: UserNotFoundException(),
              errorMessage:
                  'User is not found. Check your credentials and try again'));
        case WrongPasswordException():
          emit(AuthErrorState(
              exception: WrongPasswordException(),
              errorMessage: 'Wrong password'));
        default:
          throw UnknownAuthException;
      }
    }
  }

  Future<void> _onSignUpUser(SignUpUser event, Emitter<AuthState> emit) async {
    if (event.password != event.repeatedPassword) {
      emit(AuthErrorState(
          exception: PasswordAndRepeatedPasswordAreNotEqualException(),
          errorMessage: 'Password and repeated password are not equal'));
      return;
    }
    try {
      await _repository.signUp(event.email, event.password);
      emit(UserAuthorized(user: _repository.currentUser!));
    } on AuthException catch (e) {
      switch (e) {
        case EmailIsAlreadyUsedException():
          emit(AuthErrorState(
              exception: EmailIsAlreadyUsedException(),
              errorMessage: "Email is already in use"));

        default:
          emit(AuthErrorState(
              exception: UnknownAuthException(),
              errorMessage: "Couldn't sign up. Try again later"));
      }
    } on Exception {
      rethrow;
    }
  }

  Future<void> _onSignOutUser(
      SignOutUser event, Emitter<AuthState> emit) async {
    try {
      _repository.signOut();
      emit(UserUnauthorized());
    } on Exception catch (_) {
      emit(AuthErrorState(
          exception: UnknownAuthException(),
          errorMessage:
              "Coulndn't sign out. Check your internet connection or try later"));
    }
  }

  Future<void> _onInitUser(InitUser event, Emitter<AuthState> emit) async {
    final user = _repository.currentUser;
    if (user == null) {
      emit(UserUnauthorized());
    } else {
      emit(UserAuthorized(user: user));
    }
  }
}
