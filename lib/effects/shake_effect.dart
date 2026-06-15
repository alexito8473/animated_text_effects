import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Applies an earthquake-style shake to all characters.
///
/// Characters jitter randomly with decreasing intensity. Uses
/// deterministic noise so the shake pattern is repeatable.
///
/// ```dart
/// ShakeEffect(intensity: 6.0, frequency: 4.0)
/// ```
class ShakeEffect extends TextEffect {
  /// Maximum displacement in logical pixels.
  final double intensity;

  /// Shake oscillation frequency.
  final double frequency;

  /// Creates a shake/tremor animation.
  ///
  /// [duration] — one full shake cycle duration.
  /// [curve] — easing curve for diminishing intensity.
  /// [intensity] — maximum displacement in pixels.
  /// [frequency] — shake oscillation frequency.
  /// [delayBetweenChars] — stagger (zero for simultaneous shake).
  const ShakeEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeOut,
    this.intensity = 6.0,
    this.frequency = 4.0,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character noise-based jitter with rotation.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      final returnT = sin(curved * pi);
      final phase = noise(index) * 2 * pi;
      final angle = curved * 2 * pi * frequency + phase;

      final dx = sin(angle) * intensity * returnT;
      final dy = cos(angle * 0.7) * intensity * returnT * 0.5;
      final rot = sin(angle * 0.5) * 0.05 * returnT;

      return CharacterAnimation(
        translation: Offset(dx, dy),
        rotation: rot,
      );
    });
  }
}
