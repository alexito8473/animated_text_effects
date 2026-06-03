import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class GlitchSplitEffect extends TextEffect {
  final double splitAmount;
  final double probability;

  const GlitchSplitEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.linear,
    this.splitAmount = 4.0,
    this.probability = 0.3,
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
    final t = curved * duration.inMicroseconds / 1000000.0;

    return List.generate(charCount, (index) {
      final n = noise(index, (t * 10).floor());
      final hasSplit = n > (1.0 - probability);

      final dx = hasSplit ? (n - 0.5) * splitAmount * 2 : 0.0;

      return CharacterAnimation(
        translation: Offset(dx * returnT, 0),
        color: hasSplit && returnT > 0.001
            ? Color.lerp(Colors.red, Colors.cyan, n)!.withValues(alpha: 0.4 * returnT)
            : null,
      );
    });
  }
}
