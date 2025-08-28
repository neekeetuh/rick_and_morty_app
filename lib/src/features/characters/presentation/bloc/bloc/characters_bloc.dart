import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/repositories/characters_repository_interface.dart';

part 'characters_event.dart';
part 'characters_state.dart';

const _pagesAmount = 42;
const _pageLimit = 20;

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final ICharactersRepository _repository;
  CharactersBloc({required ICharactersRepository repository})
      : _repository = repository,
        super(const IdleCharactersState()) {
    on<CharactersEvent>((event, emit) async {
      switch (event) {
        case LoadCharactersEvent():
          await _onLoadCharactersEvent(event, emit);
        case ToggleFavoriteEvent():
          await _onToggleFavoriteEvent(event, emit);
        case RefreshCharactersEvent():
          await _onRefreshCharactersEvent(event, emit);
      }
    });
  }

  int _currentPage = 1;

  Future<void> _onLoadCharactersEvent(
      LoadCharactersEvent event, Emitter<CharactersState> emit) async {
    if (state is LoadingCharactersState) return;
    if (_currentPage > _pagesAmount) return;
    emit(LoadingCharactersState(
        characters: state.characters, favorites: state.favorites));
    try {
      final characters = await _repository.loadCharacters(
          page: _currentPage, pageLimit: _pageLimit);
      _currentPage++;
      final allCharacters = state.characters ?? [];
      allCharacters.addAll(characters);
      final allFavorites = await _repository.loadFavorites();
      emit(SucessfulCharactersState(
          characters: allCharacters, favorites: allFavorites));
    } catch (e) {
      emit(ErrorCharactersState(error: e));
    }
  }

  Future<void> _onToggleFavoriteEvent(
      ToggleFavoriteEvent event, Emitter<CharactersState> emit) async {
    try {
      await _repository.toggleFavoriteStatus(event.character);
    } catch (e) {
      emit(ErrorCharactersState(error: e));
    }

    var allCharacters = state.characters;
    var allFavorites = state.favorites;

    try {
      allCharacters
          ?.singleWhere((character) => character.id == event.character.id)
          .toggleIsFavorite();
    } catch (_) {}

    final index = allFavorites
        ?.indexWhere((character) => character.id == event.character.id);
    if (index == -1) {
      allFavorites?.add(event.character);
    } else {
      if (index != null) {
        allFavorites?.removeAt(index);
      }
    }
    emit(SucessfulCharactersState(
        characters: allCharacters, favorites: allFavorites));
  }

  Future<void> _onRefreshCharactersEvent(
      RefreshCharactersEvent event, Emitter<CharactersState> emit) async {
    emit(LoadingCharactersState(
        characters: state.characters, favorites: state.favorites));
    try {
      _currentPage = 1;
      final characters = await _repository.loadCharacters(page: _currentPage);
      _currentPage++;
      emit(SucessfulCharactersState(
          characters: characters, favorites: state.favorites));
    } catch (e) {
      emit(ErrorCharactersState(error: e));
    }
  }
}
