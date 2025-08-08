import 'package:drift/drift.dart';
import 'package:rick_and_morty_app/src/features/characters/data/database/database.dart';
import 'package:rick_and_morty_app/src/features/characters/data/dtos/character_dto.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character_status.dart';

extension CharactersModelToCompanion on Character {
  CharactersCompanion toCompanion() {
    return CharactersCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status.statusApiCode),
      species: Value(species),
      image: Value(imageUrl),
      location: Value(lastKnownLocation),
    );
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
        lastKnownLocation: location,
        isFavorite: isFavorite);
  }
}

extension CharacterDtoToModel on CharacterDto {
  Character toModel() {
    return Character(
      id: id,
      name: name,
      imageUrl: image,
      status: CharacterStatus.fromName(status),
      species: species,
      lastKnownLocation: location.name,
    );
  }
}
