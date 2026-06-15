import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Rotates each character around its center.
///
/// Characters spin for [spinCount] full rotations while scaling from
/// [scaleFrom] to 1.0, staggered for a cascading effect.
class SpinEffect extends TextEffect {
  /// Number of full 360° rotations per character.
  final int spinCount;

  /// Starting scale factor (animates to 1.0).
  final double scaleFrom;

  /// Creates a spin animation with configurable rotation and scale.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the spin.
  /// [spinCount] — number of full 360° rotations per character.
  /// [scaleFrom] — starting scale (animates to 1.0).
  /// [delayBetweenChars] — stagger delay between characters.
  const SpinEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.spinCount = 1,
    this.scaleFrom = 0.0,
    super.delayBetweenChars = const Duration(milliseconds: 60),
  });

  /// Generates per-character rotation with simultaneous scale-in.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final angle = (curved * 2 * pi * spinCount) % (2 * pi);
      final scale = scaleFrom + (1.0 - scaleFrom) * curved;

      return CharacterAnimation(
        rotation: angle,
        scale: scale,
      );
    });
  }
}
