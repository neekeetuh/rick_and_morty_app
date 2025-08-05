import 'package:rick_and_morty_app/src/features/characters/data/data_sources/local/characters_local_data_source_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/remote/characters_remote_data_source_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/repositories/characters_repository_interface.dart';

class CharactersRepository implements ICharactersRepository {
  final ICharactersRemoteDataSource _remoteDataSource;

  final ICharactersLocalDataSource _localDataSource;

  CharactersRepository({
    required ICharactersRemoteDataSource charactersDataSource,
    required ICharactersLocalDataSource localDataSource,
  })  : _remoteDataSource = charactersDataSource,
        _localDataSource = localDataSource;
  @override
  Future<List<Character>> loadCharacters(
      {int page = 1, int pageLimit = 20}) async {
    var characters = <Character>[];
    try {
      final dtos = await _remoteDataSource.fetchCharacters(page: page);
      await _localDataSource.saveCharacters(dtos);
    } catch (_) {
    } finally {
      final localDtos = await _localDataSource.fetchCharacters(page, pageLimit);
      characters = localDtos.map((dto) => Character.fromDto(dto)).toList();
    }
    return characters;
  }

  @override
  Future<List<Character>> loadFavorites() async {
    return _localDataSource.fetchFavorites();
  }

  @override
  Future<void> toggleFavoriteStatus(int characterId) async {
    _localDataSource.toggleFavoriteStatus(characterId);
  }
}
