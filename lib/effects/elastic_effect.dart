import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class ElasticEffect extends TextEffect {
  final double stretch;
  final int bounceCount;

  const ElasticEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.elasticOut,
    this.stretch = 0.3,
    this.bounceCount = 1,
    super.delayBetweenChars = const Duration(milliseconds: 60),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final wave = sin(curved * pi * bounceCount);

      final stretchX = 1.0 + stretch * wave;
      final stretchY = 1.0 - stretch * wave * 0.6;

      return CharacterAnimation(
        scaleX: stretchX,
        scaleY: stretchY,
      );
    });
  }
}
