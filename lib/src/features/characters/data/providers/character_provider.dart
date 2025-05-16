import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';

class CharacterProvider with ChangeNotifier {
  final List<Character> _allCharacters = [
    Character(
      id: 1,
      name: "Rick Sanchez",
      imageUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      status: CharacterStatus.alive,
      species: "Human",
      lastKnownLocation: "Earth (C-137)",
    ),
    Character(
      id: 2,
      name: "Morty Smith",
      imageUrl: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
      status: CharacterStatus.alive,
      species: "Human",
      lastKnownLocation: "Earth (C-137)",
      isFavorite: true,
    ),
    Character(
      id: 3,
      name: "Summer Smith",
      imageUrl: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
      status: CharacterStatus.alive,
      species: "Human",
      lastKnownLocation: "Earth (Replacement Dimension)",
    ),
    Character(
      id: 4,
      name: "Beth Smith",
      imageUrl: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
      status: CharacterStatus.alive,
      species: "Human",
      lastKnownLocation: "Earth (Replacement Dimension)",
    ),
    Character(
      id: 5,
      name: "Jerry Smith",
      imageUrl: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
      status: CharacterStatus.alive,
      species: "Human",
      lastKnownLocation: "Earth (Replacement Dimension)",
    ),
    Character(
      id: 6,
      name: "Abradolf Lincler",
      imageUrl: "https://rickandmortyapi.com/api/character/avatar/7.jpeg",
      status: CharacterStatus.unknown,
      species: "Human Clone",
      lastKnownLocation: "Testicle MonsterDimension",
    ),
    Character(
      id: 8,
      name: "Adjudicator Rick",
      imageUrl: "https://rickandmortyapi.com/api/character/avatar/8.jpeg",
      status: CharacterStatus.dead,
      species: "Human",
      lastKnownLocation: "Citadel of Ricks",
      isFavorite: true,
    ),
  ];

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
