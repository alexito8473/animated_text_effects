import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class VHSGlitchEffect extends TextEffect {
  final double jitter;
  final double colorOffset;
  final double maxBlur;

  const VHSGlitchEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.linear,
    this.jitter = 8.0,
    this.colorOffset = 4.0,
    this.maxBlur = 1.5,
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
    final t = curved * duration.inMicroseconds / 1000000.0;

    return List.generate(charCount, (index) {
      final n = noise(index, (t * 12).floor());
      final n2 = noise(index, (t * 8).floor() + 50);
      final returnT = sin(curved * pi);
      final hasGlitch = n > 0.7;

      final dx = (hasGlitch ? (n2 - 0.5) * jitter : 0.0) * returnT;
      final colorShift = (hasGlitch ? colorOffset : 0.0) * returnT;
      final blur = (hasGlitch ? maxBlur * n2 : 0.0) * returnT;
      final opacity = 1.0 - (hasGlitch ? 0.15 : 0.0) * returnT;

      return CharacterAnimation(
        translation: Offset(dx + colorShift, 0),
        blurSigma: blur,
        opacity: opacity.clamp(0.0, 1.0),
        color: hasGlitch && returnT > 0.001
            ? Colors.cyan.withValues(alpha: 0.3 * returnT)
            : null,
      );
    });
  }
}
