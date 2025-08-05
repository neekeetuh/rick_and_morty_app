import 'package:rick_and_morty_app/src/features/characters/data/dtos/character_dto.dart';
import 'package:rick_and_morty_app/src/features/characters/data/dtos/location_dto.dart';
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

  factory Character.fromDto(CharacterDto dto) {
    return Character(
      id: dto.id,
      name: dto.name,
      imageUrl: dto.image,
      status: CharacterStatus.fromName(dto.status),
      species: dto.species,
      lastKnownLocation: dto.location.name,
    );
  }

  CharacterDto toDto() {
    return CharacterDto(
      id: id,
      name: name,
      status: status.statusUiText,
      species: species,
      location: LocationDto(name: lastKnownLocation),
      image: imageUrl,
    );
  }

  void toggleIsFavorite() {
    isFavorite = !isFavorite;
  }
}
