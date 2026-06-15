import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Direction from which characters slide into position.
enum SlideDirection {
  /// Slides in from the left edge.
  left,
  /// Slides in from the right edge.
  right,
  /// Slides in from the top edge.
  up,
  /// Slides in from the bottom edge.
  down,
  /// Slides in from the top-left corner.
  topLeft,
  /// Slides in from the top-right corner.
  topRight,
  /// Slides in from the bottom-left corner.
  bottomLeft,
  /// Slides in from the bottom-right corner.
  bottomRight,
}

/// Slides each character into place from a configurable direction.
///
/// Characters enter from the chosen [SlideDirection] over [distance] pixels,
/// staggered by [delayBetweenChars].
class SlideEffect extends TextEffect {
  /// Entry direction for the slide animation.
  final SlideDirection direction;

  /// Distance in logical pixels the characters travel.
  final double distance;

  /// Creates a slide-in animation per character.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the slide.
  /// [delayBetweenChars] — stagger delay between characters.
  /// [direction] — entry direction for the slide.
  /// [distance] — travel distance in logical pixels.
  const SlideEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = const Duration(milliseconds: 30),
    this.direction = SlideDirection.left,
    this.distance = 50.0,
  });

  /// Generates per-character translated positions from the slide direction.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final remaining = 1.0 - curved;
      final offset = _getOffset(remaining * distance);
      return CharacterAnimation(translation: offset);
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
