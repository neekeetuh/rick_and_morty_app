import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/common/theme/theme_provider.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character_status.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/character_list_screen.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/widgets/character_card.dart';

class MockCharactersBloc extends MockBloc<CharactersEvent, CharactersState>
    implements CharactersBloc {}

void main() {
  late MockCharactersBloc mockCharactersBloc;

  setUpAll(() {
    // Регистрация заглушки для Mocktail
    registerFallbackValue(const LoadCharactersEvent());
  });

  setUp(() {
    mockCharactersBloc = MockCharactersBloc();
  });

  tearDown(() {
    mockCharactersBloc.close();
  });

  group('CharactersListScreen Widget Tests', () {
    testWidgets(
      'Displays a single loading indicator when in Loading state',
      (tester) async {
        // Настраиваем mock-блок для выдачи только LoadingCharactersState
        whenListen(
          mockCharactersBloc,
          Stream.fromIterable([const LoadingCharactersState()]),
          initialState:
              const IdleCharactersState(characters: [], favorites: []),
        );

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: ChangeNotifierProvider<ThemeProvider>(
                create: (_) => ThemeProvider(),
                child: BlocProvider<CharactersBloc>.value(
                  value: mockCharactersBloc,
                  child: const CharacterListScreen(),
                ),
              ),
            ),
          );
        });

        // Ожидаем, что UI перейдет в LoadingCharactersState.
        // Это должно произойти сразу после pumpWidget.
        await tester.pump();

        // Проверяем, что на экране только один индикатор загрузки и никаких карточек персонажей
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(CharacterCard), findsNothing);
      },
    );

    testWidgets(
      'Displays character cards when in Successful state',
      (tester) async {
        tester.view.devicePixelRatio = 1.0;
        tester.view.physicalSize = const Size(1000, 2000);
        addTearDown(() {
          tester.view.reset();
        });

        final mockCharacters = List.generate(
          4,
          (index) => Character(
            id: index + 1,
            name: 'Character ${index + 1}',
            imageUrl: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
            isFavorite: false,
            status: CharacterStatus.alive,
            species: '',
            lastKnownLocation: '',
          ),
        );

        // Настраиваем mock-блок для перехода из состояния LoadingCharactersState в SuccessfulCharactersState
        whenListen(
          mockCharactersBloc,
          Stream.fromIterable([
            SucessfulCharactersState(
              characters: mockCharacters,
              favorites: [],
            ),
          ]),
          initialState: const LoadingCharactersState(),
        );

        await mockNetworkImagesFor(() async {
          await tester.pumpWidget(
            MaterialApp(
              home: ChangeNotifierProvider<ThemeProvider>(
                create: (_) => ThemeProvider(),
                child: BlocProvider<CharactersBloc>.value(
                  value: mockCharactersBloc,
                  child: const CharacterListScreen(),
                ),
              ),
            ),
          );
        });

        // Ожидаем, что UI перейдет в SuccessfulCharactersState и завершит все анимации
        await tester.pump(const Duration(seconds: 3));

        // Проверяем, что на экране есть как минимум 3 карточки
        expect(find.byType(CharacterCard), findsAtLeast(3));
      },
    );
  });
}
