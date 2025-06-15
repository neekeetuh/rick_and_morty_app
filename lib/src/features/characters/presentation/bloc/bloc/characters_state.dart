part of 'characters_bloc.dart';

sealed class CharactersState {
  final List<Character>? characters;
  final List<Character>? favorites;

  const CharactersState({this.characters, this.favorites});
}

final class IdleCharactersState extends CharactersState {
  const IdleCharactersState({
    super.characters,
    super.favorites,
  });
}

final class LoadingCharactersState extends CharactersState {
  const LoadingCharactersState({
    super.characters,
    super.favorites,
  });
}

final class SucessfulCharactersState extends CharactersState {
  const SucessfulCharactersState({
    super.characters,
    super.favorites,
  });
}

final class ErrorCharactersState extends CharactersState {
  final Object error;
  const ErrorCharactersState({
    required this.error,
    super.characters,
    super.favorites,
  });
}
