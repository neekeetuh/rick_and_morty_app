import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/widgets/character_card.dart';
import 'package:rick_and_morty_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App integration test', () {
    testWidgets(
      'Displays a single loading indicator when in Loading state and character cards when in Successful state',
      (tester) async {
        // Запускаем приложение
        app.main();

        // Делаем pump, чтобы запустить UI и позволить BLoC'у отправить событие.
        await tester.pump();

        // Делаем небольшую задержку, чтобы BLoC успел выдать состояние загрузки.
        await tester.pump(const Duration(milliseconds: 50));

        // Теперь проверяем наличие индикатора. BLoC должен был переключиться в состояние загрузки.
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // Ждем, пока реальный сетевой запрос завершится.
        await tester.pumpAndSettle(const Duration(seconds: 15));

        // Проверяем, что индикатор исчез и появились карточки.
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(CharacterCard), findsAtLeast(1));
      },
    );
  });
}
