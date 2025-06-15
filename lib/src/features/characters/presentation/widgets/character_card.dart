import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/common/consts/text_styles_consts.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/widgets/character_card_image.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/widgets/character_status_row.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/widgets/toggle_favorite_button.dart';

class CharacterCard extends StatefulWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard>
    with SingleTickerProviderStateMixin<CharacterCard> {
  late AnimationController _controller;

  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Durations.short4);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutSine));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CharacterCardImage(imageUrl: widget.character.imageUrl),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.character.name,
                        style: TextStylesConsts.header2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 8.0),
                      CharacterStatusRow(status: widget.character.status),
                      const SizedBox(height: 4.0),
                      Text(
                        "${StringConsts.characterCardSpecies}: ${widget.character.species}",
                        style: TextStylesConsts.caption2
                            .copyWith(color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "${StringConsts.characterCardLoaction}: ${widget.character.lastKnownLocation}",
                        style: TextStylesConsts.caption2
                            .copyWith(color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: ToggleFavoriteButton(
                scaleAnimation: _scaleAnimation,
                isFavorite: widget.character.isFavorite,
                onPressed: _onToggleFavoritePressed,
              ),
            )
          ],
        ),
      ),
    );
  }

  _onToggleFavoritePressed() async {
    context
        .read<CharactersBloc>()
        .add(ToggleFavoriteEvent(character: widget.character));
    await _controller.forward();
    await _controller.reverse();
  }
}
