import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/repositories/characters_repository.dart';

part 'characters_event.dart';
part 'characters_state.dart';

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
          _onToggleFavoriteEvent(event, emit);
      }
    });
  }
  Future<void> _onLoadCharactersEvent(
      LoadCharactersEvent event, Emitter<CharactersState> emit) async {
    emit(const LoadingCharactersState());
    try {
      final characters = await _repository.loadCharacters();
      emit(SucessfulCharactersState(characters: characters));
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
}
