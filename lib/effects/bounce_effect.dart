import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Bounces characters vertically in sequence.
///
/// Each character jumps up and down using a sine wave, with staggered
/// timing for a cascading bounce effect.
class BounceEffect extends TextEffect {
  /// Maximum bounce height in logical pixels.
  final double height;

  /// Number of bounce cycles per character animation.
  final int bounceCount;

  /// Creates a vertical bounce animation per character.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the bounce.
  /// [height] — maximum bounce height in logical pixels.
  /// [bounceCount] — number of bounce cycles per character.
  /// [delayBetweenChars] — stagger delay between characters.
  const BounceEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.height = 12.0,
    this.bounceCount = 1,
    super.delayBetweenChars = const Duration(milliseconds: 60),
  });

  /// Generates per-character bounce animations using a sine wave.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final bounce = sin(curved * pi * bounceCount);
      final dy = -height * bounce.abs();
      return CharacterAnimation(
        translation: Offset(0, dy),
      );
    });
  }
}
