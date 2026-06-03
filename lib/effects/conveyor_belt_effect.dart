import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class ConveyorBeltEffect extends TextEffect {
  final double spacing;
  final bool reverse;

  const ConveyorBeltEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.easeInOut,
    this.spacing = 30.0,
    this.reverse = false,
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
    final dir = reverse ? 1.0 : -1.0;

    return List.generate(charCount, (index) {
      final dx = (index.toDouble() + curved) * spacing * returnT * dir;
      return CharacterAnimation(translation: Offset(dx, 0));
    });
  }
}
