import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/repositories/characters_repository.dart';

class CharacterProvider with ChangeNotifier {
  final CharactersRepository repository;

  CharacterProvider({required this.repository}) {
    loadCharacters();
  }

  List<Character> _allCharacters = [];

  Future<void> loadCharacters() async {
    _allCharacters = await repository.loadCharacters();
    notifyListeners();
  }

  List<Character> get allCharacters => _allCharacters;

  List<Character> get favoriteCharacters =>
      _allCharacters.where((char) => char.isFavorite).toList();

  void toggleFavoriteStatus(int characterId) {
    final characterIndex =
        _allCharacters.indexWhere((char) => char.id == characterId);
    if (characterIndex != -1) {
      _allCharacters[characterIndex].isFavorite =
          !_allCharacters[characterIndex].isFavorite;
      notifyListeners();
    }
  }

  void sortFavorites(String criteria) {
    List<Character> currentFavorites = favoriteCharacters;
    if (criteria == "name_asc") {
      currentFavorites.sort((a, b) => a.name.compareTo(b.name));
    } else if (criteria == "name_desc") {
      currentFavorites.sort((a, b) => b.name.compareTo(a.name));
    } else if (criteria == "status") {
      currentFavorites.sort((a, b) => a.status.index.compareTo(b.status.index));
    }
    notifyListeners();
  }
}
