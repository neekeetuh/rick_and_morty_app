import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterCardImage extends StatelessWidget {
  const CharacterCardImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width * 0.3;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        placeholder: (context, _) => ColoredBox(
          color: Colors.grey[300]!,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => SizedBox(
          width: imageSize,
          height: imageSize,
          child: ColoredBox(
            color: Colors.grey[300]!,
            child: Icon(
              Icons.broken_image,
              color: Colors.grey,
              size: imageSize * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
