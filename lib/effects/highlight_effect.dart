import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class HighlightEffect extends TextEffect {
  final Color highlightColor;
  final double opacityFrom;
  final double opacityTo;

  const HighlightEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeInOut,
    this.highlightColor = Colors.yellow,
    this.opacityFrom = 0.0,
    this.opacityTo = 0.6,
    super.delayBetweenChars = const Duration(milliseconds: 40),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final returnT = sin(curved * pi);
      final bgOpacity = opacityFrom + (opacityTo - opacityFrom) * returnT;
      return CharacterAnimation(
        backgroundColor: bgOpacity > 0.001
            ? highlightColor.withValues(alpha: bgOpacity.clamp(0.0, 1.0))
            : null,
      );
    });
  }
}
