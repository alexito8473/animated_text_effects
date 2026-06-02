import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class WaveEffect extends TextEffect {
  final double scaleMin;
  final double scaleMax;
  final int waveCount;

  const WaveEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.scaleMin = 0.5,
    this.scaleMax = 1.5,
    this.waveCount = 2,
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

    return List.generate(charCount, (index) {
      final phase = 2 * pi * waveCount * (index / charCount);
      final oscillation = sin(curved * 2 * pi - phase);
      final normalized = (oscillation + 1) / 2;
      final scale = scaleMin + (scaleMax - scaleMin) * normalized;
      return CharacterAnimation(scale: scale);
    });
  }
}
