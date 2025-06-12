import 'package:rick_and_morty_app/src/features/characters/data/data_sources/characters_data_source_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/data/dtos/character_dto.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';

class CharactersRepository {
  final CharactersDataSourceInterface _charactersDataSource;

  CharactersRepository(
      {required CharactersDataSourceInterface charactersDataSource})
      : _charactersDataSource = charactersDataSource;
  Future<List<Character>> loadCharacters({int page = 1}) async {
    var dtos = <CharacterDto>[];
    dtos = await _charactersDataSource.fetchCharacters(page: page);
    return dtos.map((dto) => Character.fromDto(dto)).toList();
  }
}
