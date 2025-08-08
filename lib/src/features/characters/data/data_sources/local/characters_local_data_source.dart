import 'package:rick_and_morty_app/src/features/characters/data/data_sources/local/characters_local_data_source_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/data/database/database.dart';
import 'package:rick_and_morty_app/src/features/characters/data/utils/characters_mapper.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';

class CharactersLocalDataSource implements ICharactersLocalDataSource {
  final IRickAndMortyDb _db;

  CharactersLocalDataSource({required IRickAndMortyDb db}) : _db = db;
  @override
  Future<List<Character>> fetchCharacters(int page, int pageLimit) async {
    return ((await _db.fetchCharacters(page, pageLimit))
        .map((characterDataClass) => characterDataClass.toModel())).toList();
  }

  @override
  Future<List<Character>> fetchFavorites() async {
    return ((await _db.fetchFavorites())
        .map((characterDataClass) => characterDataClass.toModel())).toList();
  }

  @override
  Future<void> saveCharacters(List<Character> characters) async {
    _db.upsertCharacters(
        characters.map((character) => character.toCompanion()).toList());
  }

  @override
  Future<void> toggleFavoriteStatus(int characterId) async {
    _db.toggleFavoriteStatus(characterId);
  }
}
