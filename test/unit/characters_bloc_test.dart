import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character_status.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/repositories/characters_repository_interface.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';
import 'characters_bloc_test.mocks.dart';

@GenerateMocks([ICharactersRepository])
void main() {
  late MockICharactersRepository mockRepository;
  late CharactersBloc charactersBloc;
  setUp(() {
    mockRepository = MockICharactersRepository();
    charactersBloc = CharactersBloc(repository: mockRepository);
  });
  tearDown(() {
    charactersBloc.close();
  });
  group('testing characters bloc functionality', () {
    test('the initial state of characters bloc is idle', () {
      expect(charactersBloc.state, const IdleCharactersState());
    });
    blocTest<CharactersBloc, CharactersState>(
      'emits successful state when the characters are fetched from a repository',
      build: () {
        final mockCharacters = [
          Character(
              id: 1,
              name: 'Rick Sanchez',
              imageUrl: '',
              isFavorite: false,
              status: CharacterStatus.alive,
              species: '',
              lastKnownLocation: ''),
          Character(
              id: 2,
              name: 'Morty Smith',
              imageUrl: '',
              isFavorite: false,
              status: CharacterStatus.alive,
              species: '',
              lastKnownLocation: ''),
        ];
        when(mockRepository.loadCharacters())
            .thenAnswer((_) async => mockCharacters);
        when(mockRepository.loadFavorites()).thenAnswer((_) async => []);

        return charactersBloc;
      },
      act: (bloc) => bloc.add(const LoadCharactersEvent()),
      expect: () => [
        isA<LoadingCharactersState>(),
        isA<SucessfulCharactersState>(),
      ],
      verify: (bloc) {
        verify(mockRepository.loadCharacters(page: 1, pageLimit: 20)).called(1);
        verify(mockRepository.loadFavorites()).called(1);
        final state = bloc.state;
        expect(state.characters, isNotEmpty);
        expect(state, isA<SucessfulCharactersState>());
      },
    );
  });
}
