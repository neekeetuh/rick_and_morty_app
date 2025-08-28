import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rick_and_morty_app/src/features/characters/data/data_sources/local/characters_local_data_source_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';

class FirestoreCharactersDataSource implements ICharactersLocalDataSource {
  late final FirebaseFirestore _firestore;
  late final CollectionReference<Character> _charactersRef;

  FirestoreCharactersDataSource() : _firestore = FirebaseFirestore.instance {
    _charactersRef = _firestore
        .collection('characters')
        .withConverter<Character>(
          fromFirestore: (snapshot, _) => Character.fromJson(snapshot.data()!),
          toFirestore: (character, _) => character.toJson(),
        );
  }

  @override
  Future<void> saveCharacters(List<Character> characters) async {
    final batch = _firestore.batch();

    for (final character in characters) {
      final docRef = _charactersRef.doc(character.id.toString());
      final characterMap = character.toJson();
      // Удаляем ключ isFavorite из Map перед записью, чтобы firestore не видел это поле и не перезаписывал его.
      characterMap.remove('isFavorite');
      batch.set(docRef, characterMap, SetOptions(merge: true));
    }

    await batch.commit();
  }

  @override
  Future<List<Character>> fetchCharacters(int page, int pageLimit) async {
    // Firestore не поддерживает offset напрямую, поэтому пагинацию делаем через курсоры
    var query = _charactersRef.orderBy('id').limit(pageLimit);

    if (page > 1) {
      // Находим последний документ предыдущей страницы, чтобы начать с него
      final lastDocSnapshot = await _charactersRef
          .orderBy('id')
          .limit((page - 1) * pageLimit)
          .get();

      if (lastDocSnapshot.docs.isNotEmpty) {
        final lastVisibleDoc = lastDocSnapshot.docs.last;
        query = query.startAfterDocument(lastVisibleDoc);
      }
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<Character>> fetchFavorites() async {
    final snapshot = await _charactersRef
        .where('isFavorite', isEqualTo: true)
        .orderBy('id')
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<void> toggleFavoriteStatus(int characterId) async {
    final docRef = _charactersRef.doc(characterId.toString());

    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        return;
      }

      final currentIsFavorite = snapshot.data()?.isFavorite ?? false;
      transaction.update(docRef, {'isFavorite': !currentIsFavorite});
    });
  }
}
