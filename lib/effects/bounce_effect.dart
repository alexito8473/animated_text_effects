import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class BounceEffect extends TextEffect {
  final double height;
  final int bounceCount;

  const BounceEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.height = 12.0,
    this.bounceCount = 1,
    super.delayBetweenChars = const Duration(milliseconds: 60),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final bounce = sin(curved * pi * bounceCount);
      final dy = -height * bounce.abs();
      return CharacterAnimation(
        translation: Offset(0, dy),
      );
    });
  }
}
