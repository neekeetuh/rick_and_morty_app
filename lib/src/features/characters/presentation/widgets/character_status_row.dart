import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/common/consts/text_styles_consts.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character_status.dart';

class CharacterStatusRow extends StatelessWidget {
  const CharacterStatusRow({
    super.key,
    required this.status,
  });

  final CharacterStatus status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 10,
          width: 10,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: status.statusUiColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        Expanded(
          child: Text(
            "${StringConsts.characterCardStatus}: ${status.statusUiText}",
            style: TextStylesConsts.caption2.copyWith(color: Colors.grey[700]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
