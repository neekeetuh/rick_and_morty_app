import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';

abstract interface class ICharactersLocalDataSource {
  Future<void> saveCharacters(List<Character> characters);
  Future<List<Character>> fetchCharacters(int page, int pageLimit);
  Future<List<Character>> fetchFavorites();
  Future<void> toggleFavoriteStatus(int characterId);
}
