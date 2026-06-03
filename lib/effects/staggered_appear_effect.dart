import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';
import 'slide_effect.dart';

class StaggeredAppearEffect extends TextEffect {
  final SlideDirection direction;
  final double distance;
  final double opacityFrom;

  const StaggeredAppearEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeOut,
    this.direction = SlideDirection.down,
    this.distance = 30.0,
    this.opacityFrom = 0.0,
    super.delayBetweenChars = const Duration(milliseconds: 40),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final remaining = 1.0 - curved;
      final opacity = opacityFrom + (1.0 - opacityFrom) * curved;
      final offset = _getOffset(remaining * distance);
      return CharacterAnimation(
        translation: offset,
        opacity: opacity.clamp(0.0, 1.0),
      );
    });
  }

  Offset _getOffset(double d) {
    switch (direction) {
      case SlideDirection.left:
        return Offset(-d, 0);
      case SlideDirection.right:
        return Offset(d, 0);
      case SlideDirection.up:
        return Offset(0, -d);
      case SlideDirection.down:
        return Offset(0, d);
      case SlideDirection.topLeft:
        return Offset(-d, -d);
      case SlideDirection.topRight:
        return Offset(d, -d);
      case SlideDirection.bottomLeft:
        return Offset(-d, d);
      case SlideDirection.bottomRight:
        return Offset(d, d);
    }
  }
}
