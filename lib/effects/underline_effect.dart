import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class UnderlineEffect extends TextEffect {
  final Color? lineColor;
  final double height;

  const UnderlineEffect({
    super.duration = const Duration(milliseconds: 600),
    super.curve = Curves.easeOut,
    this.lineColor,
    this.height = 2.0,
    super.delayBetweenChars = const Duration(milliseconds: 30),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final returnT = sin(curved * pi);
      return CharacterAnimation(
        underlineProgress: returnT,
        color: lineColor,
      );
    });
  }
}
