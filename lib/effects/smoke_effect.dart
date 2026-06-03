import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class SmokeEffect extends TextEffect {
  final double height;
  final double blurSigma;

  const SmokeEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeOut,
    this.height = 40.0,
    this.blurSigma = 6.0,
    super.delayBetweenChars = const Duration(milliseconds: 50),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final returnT = sin(curved * pi);

      final n = noise(index);
      final dx = (n - 0.5) * 30.0 * returnT;
      final dy = -height * returnT;
      final opacity = 1.0 - returnT;
      final blur = blurSigma * returnT;

      return CharacterAnimation(
        translation: Offset(dx, dy),
        opacity: opacity.clamp(0.0, 1.0),
        blurSigma: blur,
      );
    });
  }
}
