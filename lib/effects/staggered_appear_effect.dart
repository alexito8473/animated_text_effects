import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';
import 'slide_effect.dart';

/// Characters appear sequentially with combined slide and fade.
///
/// Each character slides in from the given [direction] while fading from
/// [opacityFrom] to 1.0, creating a staggered entrance.
class StaggeredAppearEffect extends TextEffect {
  /// Direction from which each character slides in.
  final SlideDirection direction;

  /// Slide distance in logical pixels.
  final double distance;

  /// Starting opacity before the character appears.
  final double opacityFrom;

  /// Creates a staggered slide + fade entrance effect.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the slide and fade.
  /// [direction] — entry direction for the slide.
  /// [distance] — slide distance in logical pixels.
  /// [opacityFrom] — starting opacity before appear.
  /// [delayBetweenChars] — stagger delay between characters.
  const StaggeredAppearEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeOut,
    this.direction = SlideDirection.down,
    this.distance = 30.0,
    this.opacityFrom = 0.0,
    super.delayBetweenChars = const Duration(milliseconds: 40),
  });

  /// Generates per-character slide + fade based on staggered progress.
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
