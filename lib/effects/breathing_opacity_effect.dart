import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class BreathingOpacityEffect extends TextEffect {
  final double opacityMin;

  const BreathingOpacityEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.easeInOut,
    this.opacityMin = 0.7,
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
    final t = sin(curved * pi);
    final opacity = 1.0 - (1.0 - opacityMin) * t;

    return List.generate(charCount, (_) {
      return CharacterAnimation(opacity: opacity);
    });
  }
}
