import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Wavy distortion that stretches characters like liquid.
///
/// Each character oscillates in scale (X/Y) and vertical position with
/// a unique noise-based phase, creating a fluid, wobbly appearance.
class LiquidEffect extends TextEffect {
  /// Horizontal stretch amplitude factor.
  final double amplitude;

  /// Oscillation frequency of the liquid wave.
  final double frequency;

  /// Vertical displacement amplitude in logical pixels.
  final double waveHeight;

  /// Creates a liquid/fluid distortion animation.
  ///
  /// [duration] — one full oscillation cycle duration.
  /// [curve] — easing curve for the fluid motion.
  /// [amplitude] — horizontal stretch amplitude factor.
  /// [frequency] — oscillation frequency of the wave.
  /// [waveHeight] — vertical displacement amplitude in pixels.
  /// [delayBetweenChars] — stagger (zero for simultaneous wave).
  const LiquidEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.amplitude = 0.3,
    this.frequency = 2.0,
    this.waveHeight = 6.0,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character stretch and vertical offset with noise phase.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      final phase = noise(index) * 2 * pi;
      final returnT = sin(curved * pi);
      final angle = curved * 2 * pi * frequency + phase;

      final stretchX = 1.0 + sin(angle) * amplitude * returnT;
      final stretchY = 1.0 - sin(angle) * amplitude * 0.5 * returnT;
      final dy = sin(angle * 0.7) * waveHeight * returnT;

      return CharacterAnimation(
        scaleX: stretchX,
        scaleY: stretchY,
        translation: Offset(0, dy),
      );
    });
  }
}
