part of 'characters_bloc.dart';

sealed class CharactersEvent {
  const CharactersEvent();
}

final class LoadCharactersEvent extends CharactersEvent {
  const LoadCharactersEvent();
}

final class ToggleFavoriteEvent extends CharactersEvent {
  final Character character;
  const ToggleFavoriteEvent({required this.character});
}

final class RefreshCharactersEvent extends CharactersEvent {
  const RefreshCharactersEvent();
}
