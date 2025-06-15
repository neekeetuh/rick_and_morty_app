import 'package:rick_and_morty_app/src/features/characters/data/data_sources/characters_data_source_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/data/database/database.dart';
import 'package:rick_and_morty_app/src/features/characters/data/utils/characters_mapper.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';

class CharactersRepository {
  final CharactersDataSourceInterface _charactersDataSource;
  final IRickAndMortyDb _db;

  CharactersRepository(
      {required CharactersDataSourceInterface charactersDataSource,
      required IRickAndMortyDb db})
      : _db = db,
        _charactersDataSource = charactersDataSource;
  Future<List<Character>> loadCharacters(
      {int page = 1, int pageLimit = 20}) async {
    var characters = <Character>[];
    try {
      final dtos = await _charactersDataSource.fetchCharacters(page: page);
      await _db
          .upsertCharacters((dtos.map((dto) => dto.toCompanion())).toList());
    } catch (_) {
    } finally {
      characters = ((await _db.fetchCharacters(page, pageLimit))
          .map((characterDataClass) => characterDataClass.toModel())).toList();
    }
    return characters;
  }

  Future<List<Character>> loadFavorites() async {
    return ((await _db.fetchFavorites())
        .map((characterDataClass) => characterDataClass.toModel())).toList();
  }

  Future<void> toggleFavoriteStatus(int characterId) async {
    _db.toggleFavoriteStatus(characterId);
  }
}
