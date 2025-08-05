import 'package:rick_and_morty_app/src/features/characters/data/dtos/character_dto.dart';

abstract interface class ICharactersRemoteDataSource {
  Future<List<CharacterDto>> fetchCharacters({int page = 1});
}
