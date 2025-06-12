part of 'characters_bloc.dart';

sealed class CharactersState {
  final List<Character>? characters;

  const CharactersState({this.characters});

  List<Character> get favoriteCharacters =>
      characters?.where((char) => char.isFavorite).toList() ?? [];

  void sortFavorites(String criteria) {
    if (criteria == "name_asc") {
      favoriteCharacters.sort((a, b) => a.name.compareTo(b.name));
    } else if (criteria == "name_desc") {
      favoriteCharacters.sort((a, b) => b.name.compareTo(a.name));
    } else if (criteria == "status") {
      favoriteCharacters
          .sort((a, b) => a.status.index.compareTo(b.status.index));
    }
  }
}

final class IdleCharactersState extends CharactersState {
  const IdleCharactersState({super.characters});
}

final class LoadingCharactersState extends CharactersState {
  const LoadingCharactersState({
    super.characters,
  });
}

final class SucessfulCharactersState extends CharactersState {
  const SucessfulCharactersState({
    super.characters,
  });
}

final class ErrorCharactersState extends CharactersState {
  final Object error;
  const ErrorCharactersState({
    required this.error,
    super.characters,
  });
}
