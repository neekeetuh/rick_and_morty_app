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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'status': status.statusApiCode,
      'species': species,
      'lastKnownLocation': lastKnownLocation,
      'isFavorite': isFavorite,
    };
  }

  factory Character.fromJson(Map<String, dynamic> map) {
    return Character(
      id: map['id'] as int,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      status: CharacterStatus.fromName(map['status'] as String),
      species: map['species'] as String,
      lastKnownLocation: map['lastKnownLocation'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }
}
