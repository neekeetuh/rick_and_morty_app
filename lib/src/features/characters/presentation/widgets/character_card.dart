import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/common/consts/color_consts.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/common/consts/text_styles_consts.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';
import 'package:rick_and_morty_app/src/features/characters/presentation/bloc/bloc/characters_bloc.dart';

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
    final imageWidth = MediaQuery.of(context).size.width * 0.3;
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.character.imageUrl,
                    width: imageWidth,
                    height: imageWidth,
                    fit: BoxFit.cover,
                    placeholder: (context, _) => ColoredBox(
                      color: Colors.grey[300]!,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => SizedBox(
                      width: imageWidth,
                      height: imageWidth,
                      child: ColoredBox(
                        color: Colors.grey[300]!,
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                          size: imageWidth * 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              widget.character.name,
                              style: TextStylesConsts.header2,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          SizedBox(
                            height: 10,
                            width: 10,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: widget.character.status.statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              "${StringConsts.characterCardStatus}: ${widget.character.status.statusText}",
                              style: TextStylesConsts.caption2
                                  .copyWith(color: Colors.grey[700]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
              child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return SizedBox(
                      height: 30 * _scaleAnimation.value,
                      width: 30 * _scaleAnimation.value,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 28 * _scaleAnimation.value,
                        icon: TweenAnimationBuilder(
                          tween: ColorTween(
                            end: widget.character.isFavorite
                                ? ColorConsts.favoriteIconChosen
                                : ColorConsts.favoriteIconHollow,
                            begin: widget.character.isFavorite
                                ? ColorConsts.favoriteIconHollow
                                : ColorConsts.favoriteIconChosen,
                          ),
                          duration: Durations.long1,
                          builder: (context, value, child) {
                            return Icon(
                              widget.character.isFavorite
                                  ? Icons.star
                                  : Icons.star_border,
                              color: value,
                            );
                          },
                        ),
                        onPressed: _onToggleFavoritePressed,
                      ),
                    );
                  }),
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
