import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class ProgressTextEffect extends TextEffect {
  final Color filledColor;
  final Color emptyColor;

  const ProgressTextEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.filledColor = Colors.green,
    this.emptyColor = Colors.grey,
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
    final returnT = sin(curved * pi);
    final fillIndex = (returnT * charCount).round().clamp(0, charCount);

    return List.generate(charCount, (index) {
      return CharacterAnimation(
        color: index < fillIndex ? filledColor : emptyColor,
      );
    });
  }
}
