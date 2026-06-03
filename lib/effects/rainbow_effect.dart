import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class RainbowEffect extends TextEffect {
  final double saturation;
  final double lightness;
  final int cycleCount;

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
