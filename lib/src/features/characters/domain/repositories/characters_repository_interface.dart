import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';

abstract interface class ICharactersRepository {
  Future<List<Character>> loadCharacters({int page = 1, int pageLimit = 20});
  Future<List<Character>> loadFavorites();
  Future<void> toggleFavoriteStatus(int characterId);
}
