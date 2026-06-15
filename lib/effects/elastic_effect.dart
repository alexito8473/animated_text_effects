import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Stretches characters horizontally and vertically with an elastic overshoot.
///
/// Characters squash and stretch using the `elasticOut` curve, creating
/// a bouncy rubber-band feel.
class ElasticEffect extends TextEffect {
  /// Horizontal stretch factor (0.0–1.0 range, applied as ± stretch).
  final double stretch;

  /// Number of bounce oscillation cycles.
  final int bounceCount;

  /// Creates a stretch animation with elastic easing.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve (elasticOut for overshoot).
  /// [stretch] — horizontal stretch factor (0–1 range, applied as ± stretch).
  /// [bounceCount] — oscillation cycles per animation.
  /// [delayBetweenChars] — stagger delay between characters.
  const ElasticEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.elasticOut,
    this.stretch = 0.3,
    this.bounceCount = 1,
    super.delayBetweenChars = const Duration(milliseconds: 60),
  });

  /// Generates per-character scaleX/scaleY stretch with sine oscillation.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final wave = sin(curved * pi * bounceCount);

      final stretchX = 1.0 + stretch * wave;
      final stretchY = 1.0 - stretch * wave * 0.6;

      return CharacterAnimation(
        scaleX: stretchX,
        scaleY: stretchY,
      );
    });
  }
}
