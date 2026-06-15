import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters fly in from random offsets to their final positions.
///
/// Each character originates from a unique direction and distance,
/// using deterministic noise for a chaotic but repeatable scatter.
class ScatterEffect extends TextEffect {
  /// Maximum travel distance in logical pixels.
  final double distance;

  /// Creates a scatter entrance animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the convergence.
  /// [distance] — max travel distance in logical pixels.
  /// [delayBetweenChars] — stagger delay between characters.
  const ScatterEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.distance = 150.0,
    super.delayBetweenChars = const Duration(milliseconds: 30),
  });

  /// Generates per-character fly-in from noise-based random directions.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final remaining = 1.0 - curved;

      final angle = noise(index) * 2 * pi;
      final dist = distance * (0.5 + noise(index, 1) * 0.5);
      final dx = cos(angle) * dist * remaining;
      final dy = sin(angle) * dist * remaining;

      return CharacterAnimation(
        translation: Offset(dx, dy),
        opacity: curved.clamp(0.0, 1.0),
      );
    });
  }
}
