import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Applies a sinusoidal wave pattern to character scales.
///
/// Characters scale up and down in a wave that travels across the text,
/// creating a flowing or bouncing effect.
class WaveEffect extends TextEffect {
  /// Minimum scale factor at the wave trough.
  final double scaleMin;

  /// Maximum scale factor at the wave peak.
  final double scaleMax;

  /// Number of complete waves across the text.
  final int waveCount;

  /// Creates a sinusoidal wave scale animation.
  ///
  /// [duration] — one full wave cycle duration.
  /// [curve] — easing curve for the wave.
  /// [scaleMin] — minimum scale at wave trough.
  /// [scaleMax] — maximum scale at wave peak.
  /// [waveCount] — number of complete waves across the text.
  /// [delayBetweenChars] — stagger (zero for continuous wave).
  const WaveEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.scaleMin = 0.5,
    this.scaleMax = 1.5,
    this.waveCount = 2,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character scale following a traveling sine wave.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      final phase = 2 * pi * waveCount * (index / charCount);
      final oscillation = sin(curved * 2 * pi - phase);
      final normalized = (oscillation + 1) / 2;
      final scale = scaleMin + (scaleMax - scaleMin) * normalized;
      return CharacterAnimation(scale: scale);
    });
  }
}
