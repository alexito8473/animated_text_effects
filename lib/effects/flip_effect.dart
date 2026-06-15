import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Flips characters in 3D around the X or Y axis.
///
/// Each character rotates with a perspective effect and dips in opacity
/// at the midpoint for a realistic flip appearance.
class FlipEffect extends TextEffect {
  /// Number of full 180° flips per character.
  final int flipCount;

  /// Flip axis: `true` = Y axis (horizontal flip), `false` = X axis (vertical flip).
  final bool axis;

  /// Creates a 3D flip animation on the chosen axis.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the flip.
  /// [flipCount] — number of full 180° flips per character.
  /// [axis] — true = Y axis (horizontal flip), false = X axis (vertical flip).
  /// [delayBetweenChars] — stagger delay between characters.
  const FlipEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.flipCount = 1,
    this.axis = true,
    super.delayBetweenChars = const Duration(milliseconds: 80),
  });

  /// Generates per-character 3D rotation and opacity dip at midpoint.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final wave = sin(curved * pi);
      final angle = wave * pi * flipCount;
      final opacity = 1.0 - (wave * wave);

      if (axis) {
        return CharacterAnimation(rotationY: angle, opacity: opacity.clamp(0.0, 1.0));
      } else {
        return CharacterAnimation(rotationX: angle, opacity: opacity.clamp(0.0, 1.0));
      }
    });
  }
}
