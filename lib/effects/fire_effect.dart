import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class FireEffect extends TextEffect {
  final double jitter;
  final double blurSigma;
  final double maxScale;

  const FireEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.linear,
    this.jitter = 3.0,
    this.blurSigma = 4.0,
    this.maxScale = 1.15,
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
      final n = noise(index, (t * 8).floor());
      final n2 = noise(index, (t * 6).floor() + 100);
      final returnT = sin(curved * pi);
      final hue = 15.0 + n * 25.0;
      final sat = 0.9 + n2 * 0.1;
      final light = 0.5 + n * 0.3;
      final dx = (n - 0.5) * jitter * 2 * returnT;
      final dy = -(n2 * jitter) * returnT;
      final scale = 1.0 + (maxScale - 1.0) * n2 * returnT;

      return CharacterAnimation(
        color: returnT > 0.001
            ? HSLColor.fromAHSL(1.0, hue, sat, light).toColor()
            : null,
        translation: Offset(dx, dy),
        scale: scale,
        blurSigma: blurSigma * (0.5 + n * 0.5) * returnT,
      );
    });
  }
}
