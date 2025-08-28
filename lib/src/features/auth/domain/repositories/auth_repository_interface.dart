import 'package:rick_and_morty_app/src/features/auth/domain/models/app_user.dart';

abstract interface class IAuthRepository {
  Stream<AppUser?> get authStateChanges;

  AppUser? get currentUser;

  Future<void> signUp(
    String email,
    String password,
  );

  Future<void> login(
    String email,
    String password,
  );

  Future<void> signOut();
}
