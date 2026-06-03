import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class NeonFlickerEffect extends TextEffect {
  final Color baseColor;
  final Color glowColor;
  final double blurSigma;
  final int flickerSeed;

  const NeonFlickerEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.linear,
    this.baseColor = Colors.cyan,
    this.glowColor = Colors.cyan,
    this.blurSigma = 6.0,
    this.flickerSeed = 42,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final curved = applyCurve(progress);
      final returnT = sin(curved * pi);
      final flickerT = progress * duration.inMicroseconds / 1000000.0;
      final seed = flickerSeed + index;

      final flicker = noise(seed, (flickerT * 10).floor()) > 0.6 ? 1.0 : 0.3;
      final flickerSlow = noise(seed, (flickerT * 3).floor()) > 0.5 ? 1.0 : 0.5;
      final targetOpacity = flicker * flickerSlow;
      final opacity = 1.0 + (targetOpacity - 1.0) * returnT;

      final useFlicker = returnT > 0.001;
      return CharacterAnimation(
        opacity: opacity.clamp(0.0, 1.0),
        blurSigma: useFlicker && targetOpacity > 0.5 ? blurSigma : 0.0,
        color: useFlicker
            ? (targetOpacity > 0.5 ? glowColor : baseColor)
            : null,
      );
    });
  }
}
