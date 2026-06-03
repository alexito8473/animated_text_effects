import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class PulseEffect extends TextEffect {
  final double scaleMin;
  final double scaleMax;
  final double opacityMin;

  const PulseEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeInOut,
    this.scaleMin = 1.0,
    this.scaleMax = 1.3,
    this.opacityMin = 0.85,
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
    final t = sin(curved * 2 * pi);
    final normalized = (t + 1) / 2;

    final scale = scaleMin + (scaleMax - scaleMin) * normalized;
    final opacity = opacityMin + (1.0 - opacityMin) * (1.0 - normalized * 0.5);

    return List.generate(charCount, (_) {
      return CharacterAnimation(
        scale: scale,
        opacity: opacity,
      );
    });
  }
}
