import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/src/common/consts/color_consts.dart';

class ToggleFavoriteButton extends StatelessWidget {
  const ToggleFavoriteButton(
      {super.key,
      required Animation<double> scaleAnimation,
      required bool isFavorite,
      required void Function() onPressed})
      : _isFavorite = isFavorite,
        _onPressed = onPressed,
        _scaleAnimation = scaleAnimation;

  final Animation<double> _scaleAnimation;
  final bool _isFavorite;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
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
                  end: _isFavorite
                      ? ColorConsts.favoriteIconChosen
                      : ColorConsts.favoriteIconHollow,
                  begin: _isFavorite
                      ? ColorConsts.favoriteIconHollow
                      : ColorConsts.favoriteIconChosen,
                ),
                duration: Durations.long1,
                builder: (context, value, child) {
                  return Icon(
                    _isFavorite ? Icons.star : Icons.star_border,
                    color: value,
                  );
                },
              ),
              onPressed: _onPressed,
            ),
          );
        });
  }
}
