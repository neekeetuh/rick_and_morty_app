import 'dart:ui';

import 'package:rick_and_morty_app/src/common/consts/color_consts.dart';

enum CharacterStatus {
  alive(
      statusUiColor: ColorConsts.aliveStatusColor,
      statusUiText: 'Alive',
      statusApiCode: 'Alive'),
  dead(
      statusUiColor: ColorConsts.deadStatusColor,
      statusUiText: 'Dead',
      statusApiCode: 'Dead'),
  unknown(
      statusUiColor: ColorConsts.unknownStatusColor,
      statusUiText: 'Unknown',
      statusApiCode: 'unknown');

  final Color statusUiColor;
  final String statusUiText;
  final String statusApiCode;

  const CharacterStatus(
      {required this.statusUiColor,
      required this.statusUiText,
      required this.statusApiCode});

  static CharacterStatus fromName(String statusCode) {
    return CharacterStatus.values
        .firstWhere((el) => el.statusApiCode == statusCode);
  }
}
