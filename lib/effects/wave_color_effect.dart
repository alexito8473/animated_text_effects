import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class WaveColorEffect extends TextEffect {
  final Color colorA;
  final Color colorB;
  final int waveCount;

  const WaveColorEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.colorA = Colors.blue,
    this.colorB = Colors.purple,
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
      final wave = sin(curved * 2 * pi - phase);
      final t = (wave + 1) / 2;
      final color = Color.lerp(colorA, colorB, t)!;
      return CharacterAnimation(color: color);
    });
  }
}
