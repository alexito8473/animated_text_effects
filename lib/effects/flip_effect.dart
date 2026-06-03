import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class FlipEffect extends TextEffect {
  final int flipCount;
  final bool axis;

  const FlipEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.flipCount = 1,
    this.axis = true,
    super.delayBetweenChars = const Duration(milliseconds: 80),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final wave = sin(curved * pi);
      final angle = wave * pi * flipCount;
      final opacity = 1.0 - (wave * wave);

      if (axis) {
        return CharacterAnimation(rotationY: angle, opacity: opacity.clamp(0.0, 1.0));
      } else {
        return CharacterAnimation(rotationX: angle, opacity: opacity.clamp(0.0, 1.0));
      }
    });
  }
}
