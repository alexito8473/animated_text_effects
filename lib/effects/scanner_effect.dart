import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class ScannerEffect extends TextEffect {
  final Color scanColor;
  final double scanWidth;
  final double glowWidth;

  const ScannerEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeInOut,
    this.scanColor = Colors.cyan,
    this.scanWidth = 0.15,
    this.glowWidth = 0.3,
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
      final scanPos = curved * charCount;
      final lastRevealed = scanPos - 1;
      final maxDist = (charCount - 1).clamp(1, charCount);
      final dist = lastRevealed >= 0
          ? (index - lastRevealed).abs() / maxDist
          : double.infinity;

      Color? color;
      if (dist < glowWidth) {
        final intensity = (1.0 - dist / glowWidth).clamp(0.0, 1.0);
        if (dist < scanWidth) {
          color = scanColor.withValues(alpha: 0.8 + intensity * 0.2);
        } else {
          color = scanColor.withValues(alpha: intensity * 0.3);
        }
      }

      return CharacterAnimation(
        clipProgress: index < scanPos.ceil() ? 1.0 : 0.0,
        color: color,
      );
    });
  }
}
