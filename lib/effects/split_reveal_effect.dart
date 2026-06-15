import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters split apart from the center and fade in.
///
/// Left-half characters slide left, right-half characters slide right,
/// and the center character stays in place. Each character fades from
/// transparent to opaque, creating a dramatic curtain-reveal effect.
class SplitRevealEffect extends TextEffect {
  /// Maximum horizontal travel distance in logical pixels.
  final double distance;

  /// Creates a split-reveal entrance animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the slide and fade.
  /// [delayBetweenChars] — stagger delay between characters.
  /// [distance] — how far characters travel from center.
  const SplitRevealEffect({
    super.duration = const Duration(milliseconds: 700),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = const Duration(milliseconds: 20),
    this.distance = 80.0,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount <= 1) return List.filled(charCount, const CharacterAnimation());
    final center = (charCount - 1) / 2.0;

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      // Determine direction: left (-1), right (+1), or center (0).
      final offset = index - center;
      final dir = offset < 0 ? -1.0 : (offset > 0 ? 1.0 : 0.0);
      final dx = dir * distance * (1.0 - curved);

      return CharacterAnimation(
        translation: Offset(dx, 0),
        opacity: curved.clamp(0.0, 1.0),
      );
    });
  }
}
