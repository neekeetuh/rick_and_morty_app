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
EMULATOR_ID=$(adb devices | grep emulator | cut -f1)

# Check if an emulator was found.
if [ -z "$EMULATOR_ID" ]; then
  echo "Error: No emulator found. Exiting."
  exit 1
fi

echo "Found emulator: $EMULATOR_ID"

# The command to run integration tests on the detected emulator.
flutter test integration_test/integration_test.dart -d "$EMULATOR_ID"

echo "--- Все тесты успешно выполнены! ---"