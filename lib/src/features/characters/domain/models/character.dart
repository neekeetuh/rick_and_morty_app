import 'package:rick_and_morty_app/src/features/characters/domain/models/character_status.dart';

class Character {
  final int id;
  final String name;
  final String imageUrl;
  final CharacterStatus status;
  final String species;
  final String lastKnownLocation;
  bool isFavorite;

  Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.species,
    required this.lastKnownLocation,
    this.isFavorite = false,
  });

  void toggleIsFavorite() {
    isFavorite = !isFavorite;
  }
}
