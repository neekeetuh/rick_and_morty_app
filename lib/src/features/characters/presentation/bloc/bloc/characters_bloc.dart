import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/repositories/characters_repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

const _pagesAmount = 42;

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository _repository;
  CharactersBloc({required CharactersRepository repository})
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
    emit(LoadingCharactersState(characters: state.characters));
    try {
      final characters = await _repository.loadCharacters(page: _currentPage);
      _currentPage++;
      final allCharacters = state.characters ?? [];
      allCharacters.addAll(characters);
      emit(SucessfulCharactersState(characters: allCharacters));
    } on Exception catch (e) {
      emit(ErrorCharactersState(error: e));
    } finally {
      emit(IdleCharactersState(characters: state.characters));
    }
  }

  Future<void> _onToggleFavoriteEvent(
      ToggleFavoriteEvent event, Emitter<CharactersState> emit) async {
    event.character.isFavorite = !event.character.isFavorite;
    emit(SucessfulCharactersState(characters: state.characters));
    emit(IdleCharactersState(characters: state.characters));
  }

  Future<void> _onRefreshCharactersEvent(
      RefreshCharactersEvent event, Emitter<CharactersState> emit) async {
    emit(LoadingCharactersState(characters: state.characters));
    try {
      _currentPage = 1;
      final characters = await _repository.loadCharacters(page: _currentPage);
      _currentPage++;
      emit(SucessfulCharactersState(characters: characters));
    } on Exception catch (e) {
      emit(ErrorCharactersState(error: e));
    } finally {
      emit(IdleCharactersState(characters: state.characters));
    }
  }
}
