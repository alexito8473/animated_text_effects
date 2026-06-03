import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class SparkleTwinkleEffect extends TextEffect {
  final Color sparkleColor;
  final double sparkleScale;
  final double sparkleBlur;

  const SparkleTwinkleEffect({
    super.duration = const Duration(milliseconds: 2500),
    super.curve = Curves.easeInOut,
    this.sparkleColor = Colors.amber,
    this.sparkleScale = 1.4,
    this.sparkleBlur = 4.0,
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
    final returnT = sin(curved * pi);
    final t = curved * duration.inMicroseconds / 1000000.0;

    return List.generate(charCount, (index) {
      final n = noise(index, (t * 6).floor());
      final hasSparkle = n > 0.6;
      final sparkle = sin(curved * 2 * pi * (1.0 + n * 2.0));
      final intensity = (sparkle + 1) / 2 * returnT;

      return CharacterAnimation(
        scale: hasSparkle ? 1.0 + (sparkleScale - 1.0) * intensity : 1.0,
        color: hasSparkle && returnT > 0.001
            ? sparkleColor.withValues(alpha: (0.3 + intensity * 0.7).clamp(0.0, 1.0))
            : null,
        blurSigma: hasSparkle ? sparkleBlur * intensity : 0.0,
      );
    });
  }
}
