import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class RippleEffect extends TextEffect {
  final double scaleMin;
  final double scaleMax;
  final double height;
  final double opacityMin;

  const RippleEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeOut,
    this.scaleMin = 0.5,
    this.scaleMax = 1.3,
    this.height = 20.0,
    this.opacityMin = 0.0,
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
      final center = (charCount - 1) / 2.0;
      final dist = (index - center).abs() / max(center, 1.0);

      final returnT = sin(curved * pi);
      final localProgress = (curved - dist * 0.3).clamp(0.0, 1.0);
      final wave = sin(localProgress * pi);
      final eased = localProgress * (2 - localProgress);

      final scale = 1.0 + (scaleMin + (scaleMax - scaleMin) * wave - 1.0) * returnT;
      final dy = -height * wave * returnT;
      final opacity = 1.0 + (opacityMin + (1.0 - opacityMin) * eased - 1.0) * returnT;

      return CharacterAnimation(
        scale: scale,
        translation: Offset(0, dy),
        opacity: opacity.clamp(0.0, 1.0),
      );
    });
  }
}
