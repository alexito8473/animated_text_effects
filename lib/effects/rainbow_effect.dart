import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Cycles rainbow HSL colors across characters over time.
///
/// Each character gets a distinct hue offset, creating a multicolored
/// sweep that rotates through the color wheel.
class RainbowEffect extends TextEffect {
  /// HSL saturation of the colors (0.0–1.0).
  final double saturation;

  /// HSL lightness of the colors (0.0–1.0).
  final double lightness;

  /// Number of full color cycles during one animation.
  final int cycleCount;

  /// Creates a rainbow color cycling animation.
  ///
  /// [duration] — one full color cycle duration.
  /// [curve] — easing (linear for continuous hue shift).
  /// [saturation] — HSL saturation (0–1).
  /// [lightness] — HSL lightness (0–1).
  /// [cycleCount] — full color wheel rotations per animation.
  /// [delayBetweenChars] — stagger (zero for all-char rainbow).
  const RainbowEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.linear,
    this.saturation = 0.8,
    this.lightness = 0.6,
    this.cycleCount = 1,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character hue-shifted colors across the rainbow.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      final hue = (index / charCount + curved * cycleCount) % 1.0;
      final color = HSLColor.fromAHSL(1.0, hue * 360, saturation, lightness).toColor();
      return CharacterAnimation(color: color);
    });
  }
}
