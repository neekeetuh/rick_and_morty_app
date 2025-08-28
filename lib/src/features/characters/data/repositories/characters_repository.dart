import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/local/characters_local_data_source_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/remote/characters_remote_data_source_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/data/utils/characters_mapper.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/repositories/characters_repository_interface.dart';

class CharactersRepository implements ICharactersRepository {
  final ICharactersRemoteDataSource _remoteDataSource;

  final ICharactersLocalDataSource _localDataSource;

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

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
      await _localDataSource
          .saveCharacters(dtos.map((dto) => dto.toModel()).toList());
    } catch (_) {
    } finally {
      characters = await _localDataSource.fetchCharacters(page, pageLimit);
    }
    return characters;
  }

  @override
  Future<List<Character>> loadFavorites() async {
    return _localDataSource.fetchFavorites();
  }

  @override
  Future<void> toggleFavoriteStatus(Character character) async {
    try {
      await _localDataSource.toggleFavoriteStatus(character.id);
      if (character.isFavorite) {
        await _analytics.logEvent(
          name: 'favorite_removed',
          parameters: {
            'character_id': character.id,
            'character_name': character.name,
          },
        );
      } else {
        await _analytics.logEvent(
          name: 'favorite_added',
          parameters: {
            'character_id': character.id,
            'character_name': character.name,
          },
        );
      }
    } catch (_) {
      rethrow;
    }
  }
}
