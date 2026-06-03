import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class RevealEffect extends TextEffect {
  final bool horizontal;
  final double clipFrom;

  const RevealEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeOut,
    this.horizontal = true,
    this.clipFrom = 0.0,
    super.delayBetweenChars = const Duration(milliseconds: 30),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final clip = clipFrom + (1.0 - clipFrom) * curved;
      return CharacterAnimation(clipProgress: clip.clamp(0.0, 1.0));
    });
  }
}
