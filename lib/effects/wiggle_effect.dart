import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class WiggleEffect extends TextEffect {
  final double amplitude;
  final double frequency;
  final double rotationAmplitude;

  const WiggleEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeInOut,
    this.amplitude = 4.0,
    this.frequency = 3.0,
    this.rotationAmplitude = 0.05,
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
      final dx = sin(angle) * amplitude * returnT;
      final dy = cos(angle * 0.7) * amplitude * returnT;
      final rot = sin(angle * 0.5) * rotationAmplitude * returnT;

      return CharacterAnimation(
        translation: Offset(dx, dy),
        rotation: rot,
      );
    });
  }
}
