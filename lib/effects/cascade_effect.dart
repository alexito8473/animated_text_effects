import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters tip over in sequence like a row of dominos.
///
/// Each character rotates backward (rotationY) and fades, starting from
/// the first character and cascading through the rest, creating a domino
/// collapse effect.
class CascadeEffect extends TextEffect {
  /// Maximum rotation angle in radians at the cascade peak.
  final double maxRotation;

  /// Creates a domino cascade fall animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the fall.
  /// [maxRotation] — max rotationY angle in radians.
  /// [delayBetweenChars] — stagger delay between characters (domino spacing).
  const CascadeEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeIn,
    this.maxRotation = pi / 2,
    super.delayBetweenChars = const Duration(milliseconds: 50),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final wave = sin(curved * pi);
      final rot = wave * maxRotation;
      final scaleY = 1.0 - wave.abs() * 0.15;

      return CharacterAnimation(
        rotationY: rot,
        scaleY: scaleY,
        opacity: (1.0 - wave.abs() * 0.4).clamp(0.0, 1.0),
      );
    });
  }
}
