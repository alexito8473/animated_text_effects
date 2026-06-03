import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class LiquidEffect extends TextEffect {
  final double amplitude;
  final double frequency;
  final double waveHeight;

  const LiquidEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.amplitude = 0.3,
    this.frequency = 2.0,
    this.waveHeight = 6.0,
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
      final phase = noise(index) * 2 * pi;
      final returnT = sin(curved * pi);
      final angle = curved * 2 * pi * frequency + phase;

      final stretchX = 1.0 + sin(angle) * amplitude * returnT;
      final stretchY = 1.0 - sin(angle) * amplitude * 0.5 * returnT;
      final dy = sin(angle * 0.7) * waveHeight * returnT;

      return CharacterAnimation(
        scaleX: stretchX,
        scaleY: stretchY,
        translation: Offset(0, dy),
      );
    });
  }
}
