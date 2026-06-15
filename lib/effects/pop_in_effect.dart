import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters pop into view with a scale overshoot.
///
/// Each character scales from 0 to a peak above 1.0, then settles back
/// to 1.0, creating a lively bouncing entrance.
///
/// ```dart
/// PopInEffect(scalePeak: 1.3)
/// ```
class PopInEffect extends TextEffect {
  /// Peak scale factor (1.3 = 30% overshoot above normal size).
  final double scalePeak;

  /// Creates a pop-in animation with scale overshoot.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the pop.
  /// [delayBetweenChars] — stagger delay between characters.
  /// [scalePeak] — peak scale factor (1.3 = 30% overshoot).
  const PopInEffect({
    super.duration = const Duration(milliseconds: 600),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = const Duration(milliseconds: 40),
    this.scalePeak = 1.3,
  });

  /// Generates per-character scale overshoot with fade-in.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final pop = sin(curved * pi);
      final scale = 1.0 + (scalePeak - 1.0) * pop * (1.0 - curved);

      return CharacterAnimation(
        scale: scale,
        opacity: curved.clamp(0.0, 1.0),
      );
    });
  }
}
