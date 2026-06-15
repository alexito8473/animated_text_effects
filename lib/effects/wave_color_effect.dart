import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Oscillates character colors between two colors in a sinusoidal wave.
///
/// Colors sweep across the text from [colorA] to [colorB] and back,
/// creating a flowing color wave.
class WaveColorEffect extends TextEffect {
  /// First color in the oscillation pair.
  final Color colorA;

  /// Second color in the oscillation pair.
  final Color colorB;

  /// Number of color waves across the text.
  final int waveCount;

  /// Creates a wave color oscillation effect.
  ///
  /// [duration] — one full color wave cycle duration.
  /// [curve] — easing curve for the wave.
  /// [colorA] — first color in the oscillation pair.
  /// [colorB] — second color in the oscillation pair.
  /// [waveCount] — number of color waves across the text.
  /// [delayBetweenChars] — stagger (zero for continuous wave).
  const WaveColorEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.colorA = Colors.blue,
    this.colorB = Colors.purple,
    this.waveCount = 2,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character color oscillation between [colorA] and [colorB].
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      final phase = 2 * pi * waveCount * (index / charCount);
      final wave = sin(curved * 2 * pi - phase);
      final t = ((wave + 1) / 2 * 10000).round() / 10000.0;
      final color = Color.lerp(colorA, colorB, t)!;
      return CharacterAnimation(color: color);
    });
  }
}
