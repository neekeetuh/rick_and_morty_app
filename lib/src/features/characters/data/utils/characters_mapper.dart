import 'package:drift/drift.dart';
import 'package:rick_and_morty_app/src/features/characters/data/database/database.dart';
import 'package:rick_and_morty_app/src/features/characters/data/dtos/character_dto.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character_status.dart';

extension CharactersDtoToCompanion on CharacterDto {
  CharactersCompanion toCompanion() {
    return CharactersCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      species: Value(species),
      image: Value(image),
      location: Value(location),
    );
  }
}

extension CharactersDataClassToDto on CharacterDataClass {
  CharacterDto toDto() {
    return CharacterDto(
        id: id,
        image: image,
        name: name,
        status: status,
        species: species,
        location: location);
  }
}

extension CharactersDataClassToModel on CharacterDataClass {
  Character toModel() {
    return Character(
        id: id,
        name: name,
        imageUrl: image,
        status: CharacterStatus.fromName(status),
        species: species,
        lastKnownLocation: location.name,
        isFavorite: isFavorite);
  }
}
