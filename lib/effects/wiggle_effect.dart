import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Applies random jitter and rotation to each character.
///
/// Uses deterministic noise so each character has a unique, repeatable
/// wiggle pattern with configurable [amplitude], [frequency], and rotation.
class WiggleEffect extends TextEffect {
  /// Maximum horizontal/vertical displacement in logical pixels.
  final double amplitude;

  /// Oscillation frequency of the wiggle.
  final double frequency;

  /// Maximum rotation angle in radians for the wiggle.
  final double rotationAmplitude;

  /// Creates a wiggling jitter effect per character.
  ///
  /// [duration] — one full wiggle cycle duration.
  /// [curve] — easing curve for the wiggle.
  /// [amplitude] — max horizontal/vertical displacement in pixels.
  /// [frequency] — oscillation frequency of the wiggle.
  /// [rotationAmplitude] — max rotation angle in radians.
  /// [delayBetweenChars] — stagger (zero for simultaneous wiggle).
  const WiggleEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeInOut,
    this.amplitude = 4.0,
    this.frequency = 3.0,
    this.rotationAmplitude = 0.05,
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
      final phase = noise(index) * 2 * pi;
      final returnT = curved * (1.0 - curved) * 4;
      final angle = curved * 2 * pi * frequency + phase;
      final dx = sin(angle) * amplitude * returnT;
      final dy = cos(angle * 0.7) * amplitude * returnT;
      final rot = sin(angle * 0.5) * rotationAmplitude * returnT;

      return CharacterAnimation(
        translation: Offset(dx, dy),
        rotation: rot,
      );
    });
  }
}
