#!/bin/bash

set -e

echo "--- Начинаем подготовку проекта ---"

flutter clean
flutter pub get

echo "--- Анализ Dart-кода ---"
dart analyze

echo "--- Запускаем юнит-тесты ---"
flutter test test/unit/characters_bloc_test.dart

echo "--- Запускаем виджет-тесты ---"
flutter test test/widget/characters_list_screen_widget_test.dart

echo "--- Запускаем интеграционные тесты ---"

flutter test integration_test/integration_test.dart

echo "--- Все тесты успешно выполнены! ---"