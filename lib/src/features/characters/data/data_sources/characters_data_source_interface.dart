import 'package:rick_and_morty_app/src/features/characters/data/dtos/character_dto.dart';

abstract interface class CharactersDataSourceInterface {
  Future<List<CharacterDto>> fetchCharacters({int page = 1});
}

abstract interface class SavableCharactersDataSourceInterface
    implements CharactersDataSourceInterface {
  Future<void> saveCharacters(List<CharacterDto> characters);
}
