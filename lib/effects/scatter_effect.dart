import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class ScatterEffect extends TextEffect {
  final double distance;

  const ScatterEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.distance = 150.0,
    super.delayBetweenChars = const Duration(milliseconds: 30),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final remaining = 1.0 - curved;

      final angle = noise(index) * 2 * pi;
      final dist = distance * (0.5 + noise(index, 1) * 0.5);
      final dx = cos(angle) * dist * remaining;
      final dy = sin(angle) * dist * remaining;

      return CharacterAnimation(
        translation: Offset(dx, dy),
        opacity: curved.clamp(0.0, 1.0),
      );
    });
  }
}
