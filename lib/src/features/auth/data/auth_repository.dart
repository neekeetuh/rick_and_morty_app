import 'package:firebase_auth/firebase_auth.dart';
import 'package:rick_and_morty_app/src/features/auth/data/utils/user_mappers.dart';
import 'package:rick_and_morty_app/src/features/auth/domain/exceptions/auth_exceptions.dart';
import 'package:rick_and_morty_app/src/features/auth/domain/models/app_user.dart';
import 'package:rick_and_morty_app/src/features/auth/domain/repositories/auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  @override
  Stream<AppUser?> get authStateChanges => FirebaseAuth.instance
      .authStateChanges()
      .map((firebaseUser) => firebaseUser?.toModel());

  @override
  AppUser? get currentUser => FirebaseAuth.instance.currentUser?.toModel();

  @override
  Future<void> signUp(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailIsAlreadyUsedException;

        default:
          throw UnknownAuthException;
      }
    }
  }

  @override
  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundException;
        case 'wrong-password':
          throw WrongPasswordException;

        default:
          throw UnknownAuthException;
      }
    }
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }
}
