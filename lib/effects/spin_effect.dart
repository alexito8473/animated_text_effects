import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class SpinEffect extends TextEffect {
  final int spinCount;
  final double scaleFrom;

  const SpinEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.spinCount = 1,
    this.scaleFrom = 0.0,
    super.delayBetweenChars = const Duration(milliseconds: 60),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final angle = curved * 2 * pi * spinCount;
      final scale = scaleFrom + (1.0 - scaleFrom) * curved;

      return CharacterAnimation(
        rotation: angle,
        scale: scale,
      );
    });
  }
}
