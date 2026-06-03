import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class GlowEffect extends TextEffect {
  final double blurMin;
  final double blurMax;
  final double opacityMin;
  final double opacityMax;
  final Color? glowColor;

  const GlowEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.blurMin = 3.0,
    this.blurMax = 12.0,
    this.opacityMin = 0.6,
    this.opacityMax = 1.0,
    this.glowColor,
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
    final breath = (sin(curved * 2 * pi) + 1) / 2;

    final blur = blurMin + (blurMax - blurMin) * breath;
    final opacity = opacityMin + (opacityMax - opacityMin) * breath;

    return List.generate(charCount, (_) {
      return CharacterAnimation(
        blurSigma: blur,
        opacity: opacity,
        color: glowColor,
      );
    });
  }
}
