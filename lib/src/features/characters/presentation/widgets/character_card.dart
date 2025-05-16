import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/src/common/consts/color_consts.dart';
import 'package:rick_and_morty_app/src/common/consts/string_consts.dart';
import 'package:rick_and_morty_app/src/common/consts/text_styles_consts.dart';
import 'package:rick_and_morty_app/src/features/characters/data/providers/character_provider.dart';
import 'package:rick_and_morty_app/src/features/characters/domain/models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width * 0.3;
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                character.imageUrl,
                width: imageWidth,
                height: imageWidth,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: imageWidth,
                    height: imageWidth,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (context, _, __) {
                  return Container(
                    width: imageWidth,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: imageWidth * 0.5,
                    ),
                  );
                },
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
                          character.name,
                          style: TextStylesConsts.header2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 28,
                          icon: Icon(
                            character.isFavorite
                                ? Icons.star
                                : Icons.star_border,
                            color: character.isFavorite
                                ? ColorConsts.favoriteIconChosen
                                : ColorConsts.favoriteIconHollow,
                          ),
                          onPressed: () {
                            context
                                .read<CharacterProvider>()
                                .toggleFavoriteStatus(character.id);
                          },
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
                            color: character.status.statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          "${StringConsts.characterCardStatus}: ${character.status.statusText}",
                          style: TextStylesConsts.caption2
                              .copyWith(color: Colors.grey[700]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "${StringConsts.characterCardSpecies}: ${character.species}",
                    style: TextStylesConsts.caption2
                        .copyWith(color: Colors.grey[700]),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "${StringConsts.characterCardLoaction}: ${character.lastKnownLocation}",
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
      ),
    );
  }
}
