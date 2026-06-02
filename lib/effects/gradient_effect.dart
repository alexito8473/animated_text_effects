import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class GradientEffect extends TextEffect {
  final List<Color> colors;
  final Axis direction;

  const GradientEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.linear,
    this.colors = const [Colors.blue, Colors.purple, Colors.pink],
    this.direction = Axis.horizontal,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0 || colors.isEmpty) return [];

    return List.generate(charCount, (index) {
      final t = index / (charCount - 1).clamp(1, charCount);
      final shifted = (t + progress) % 1.0;
      final color = _lerpColors(shifted);
      return CharacterAnimation(color: color);
    });
  }

  Color _lerpColors(double t) {
    if (colors.length == 1) return colors.first;
    final clamped = t.clamp(0.0, 1.0);
    final segment = clamped * (colors.length - 1);
    final fromIndex = segment.floor();
    final toIndex = (fromIndex + 1).clamp(0, colors.length - 1);
    final localT = segment - fromIndex;
    return Color.lerp(colors[fromIndex], colors[toIndex], localT)!;
  }
}
