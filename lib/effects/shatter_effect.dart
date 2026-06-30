import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters fly together from scattered fragments to their final form.
///
/// Each character starts at a random offset, rotation, and scale like
/// shards of glass, converging into the complete text with a settling
/// bounce.
class ShatterEffect extends TextEffect {
  /// Maximum travel distance from final position in logical pixels.
  final double distance;

  /// Number of settling bounce oscillations.
  final int bounceCount;

  /// Creates a shatter/reconstruct animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for convergence.
  /// [distance] — max travel distance in logical pixels.
  /// [bounceCount] — number of bounce oscillations on settle.
  /// [delayBetweenChars] — stagger delay between characters.
  const ShatterEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.distance = 120.0,
    this.bounceCount = 2,
    super.delayBetweenChars = const Duration(milliseconds: 25),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final remaining = 1.0 - curved;
      final angle = noise(index) * 2 * pi;
      final dist = distance * (0.3 + noise(index, 1) * 0.7);
      final dx = cos(angle) * dist * remaining;
      final dy = sin(angle) * dist * remaining;
      final rot = (noise(index, 2) - 0.5) * pi * remaining;
      final s = 0.3 + 0.7 * curved;
      final bounce = sin(curved * pi * bounceCount) * remaining * 0.1;

      return CharacterAnimation(
        translation: Offset(dx, dy + bounce * dist * 0.3),
        rotation: rot,
        scale: s,
        opacity: curved.clamp(0.0, 1.0),
      );
    });
  }
}
