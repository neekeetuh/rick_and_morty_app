import 'package:rick_and_morty_app/src/features/characters/data/dtos/character_dto.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';

abstract interface class ICharactersLocalDataSource {
  Future<void> saveCharacters(List<CharacterDto> characters);
  Future<List<CharacterDto>> fetchCharacters(int page, int pageLimit);
  Future<List<Character>> fetchFavorites();
  Future<void> toggleFavoriteStatus(int characterId);
}
