#!/bin/bash

set -e

# Захватываем ID эмулятора из аргумента
EMULATOR_ID=$2
if [ -z "$EMULATOR_ID" ]; then
    # Если аргумент не был передан, находим ID эмулятора автоматически
    echo "ID эмулятора не предоставлен, ищем автоматически..."
    EMULATOR_ID=$(adb devices | grep emulator | cut -f1)
fi

# Проверяем, найден ли эмулятор
if [ -z "$EMULATOR_ID" ]; then
    echo "Ошибка: Эмулятор не найден. Выход."
    exit 1
fi

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

echo "Используемый эмулятор: $EMULATOR_ID"
# The command to run integration tests on the detected emulator.
flutter test integration_test/integration_test.dart -d "$EMULATOR_ID"

echo "--- Все тесты успешно выполнены! ---"