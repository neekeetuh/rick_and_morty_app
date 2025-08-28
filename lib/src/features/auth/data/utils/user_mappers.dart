import 'package:firebase_auth/firebase_auth.dart';
import 'package:rick_and_morty_app/src/features/auth/domain/models/app_user.dart';

extension FirebaseUserToModel on User {
  AppUser toModel() {
    return AppUser(
        uid: uid,
        displayName: displayName ?? '',
        email: email ?? '',
        photoUrl: photoURL);
  }
}
