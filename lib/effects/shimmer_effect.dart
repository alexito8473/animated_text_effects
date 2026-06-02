import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class ShimmerEffect extends TextEffect {
  final Color baseColor;
  final Color highlightColor;
  final double width;

  const ShimmerEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
    this.width = 0.3,
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
      final charPos = index / (charCount - 1).clamp(1, charCount);
      final highlightCenter = curved;
      final dist = (charPos - highlightCenter).abs();
      final intensity = (1 - (dist / width)).clamp(0.0, 1.0);
      final color = Color.lerp(baseColor, highlightColor, intensity)!;
      return CharacterAnimation(color: color);
    });
  }
}
