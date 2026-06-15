import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters undulate in a 3D wave like a waving flag.
///
/// Uses [CharacterAnimation.rotationY] in a sinusoidal pattern that travels across the text,
/// creating a perspective depth effect similar to a fluttering banner.
///
/// ```dart
/// FlagWaveEffect(amplitude: 0.4, waveCount: 3)
/// ```
class FlagWaveEffect extends TextEffect {
  /// Maximum rotationY angle in radians (higher = more dramatic wave).
  final double amplitude;

  /// Number of wave crests across the text.
  final int waveCount;

  /// Creates a flag-waving 3D rotation effect.
  ///
  /// [duration] — one full wave cycle duration.
  /// [curve] — easing curve for the undulation.
  /// [amplitude] — max rotationY angle in radians.
  /// [waveCount] — number of wave crests across the text.
  /// [delayBetweenChars] — stagger (zero for simultaneous wave).
  const FlagWaveEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.amplitude = 0.4,
    this.waveCount = 2,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character rotationY following a traveling sine wave.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      final phase = 2 * pi * waveCount * (index / max(charCount - 1, 1));
      final wave = sin(curved * 2 * pi - phase);
      final returnT = sin(curved * pi);
      final rotationY = wave * amplitude * returnT;

      return CharacterAnimation(rotationY: rotationY);
    });
  }
}
