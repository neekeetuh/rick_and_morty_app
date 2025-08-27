#!/bin/bash

set -e

# Захватываем ID эмулятора из аргумента
EMULATOR_ID=$1

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

# Создаем переменную, которая будет содержать флаг -d, если ID эмулятора передан.
# Если ID не передан, переменная будет пустой, и флаг не будет использоваться.
DEVICE_FLAG=""
if [ -n "$EMULATOR_ID" ]; then
    echo "Используемый эмулятор: $EMULATOR_ID"
    DEVICE_FLAG="-d $EMULATOR_ID"
else
    echo "ID эмулятора не указан, flutter test будет искать его автоматически."
fi

# The command to run integration tests on the detected emulator.
flutter test integration_test/integration_test.dart $DEVICE_FLAG"

echo "--- Все тесты успешно выполнены! ---"