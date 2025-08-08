import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';
part 'tables.dart';

abstract interface class IRickAndMortyDb {
  Future<List<CharacterDataClass>> fetchCharacters(int page, int pageLimit);
  Future<void> upsertCharacters(List<CharactersCompanion> characterCompanions);
  Future<List<CharacterDataClass>> fetchFavorites();
  Future<void> toggleFavoriteStatus(int characterId);
}

@DriftDatabase(tables: [Characters])
class RickAndMortyDatabase extends _$RickAndMortyDatabase
    implements IRickAndMortyDb {
  RickAndMortyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'rick_and_morty_db');
  }

  @override
  Future<List<CharacterDataClass>> fetchFavorites() async {
    return ((select(characters)..where((character) => character.isFavorite.equals(true)))
          ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
  }

  @override
  Future<List<CharacterDataClass>> fetchCharacters(
      int page, int pageLimit) async {
    return ((select(characters)..limit(pageLimit, offset: ((page - 1) * pageLimit)))
          ..orderBy([(t) => OrderingTerm(expression: t.id)]))
        .get();
  }

  @override
  Future<void> upsertCharacters(
      List<CharactersCompanion> characterCompanions) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        characters,
        characterCompanions,
      );
    });
  }

  @override
  Future<void> toggleFavoriteStatus(int characterId) async {
    final currentCharacter = await (select(characters)
          ..where((character) => character.id.equals(characterId)))
        .getSingleOrNull();
    if (currentCharacter != null) {
      await (update(characters)
            ..where((character) => character.id.equals(characterId)))
          .write(
        CharactersCompanion(
          isFavorite: Value(!currentCharacter.isFavorite),
        ),
      );
    }
  }
}
