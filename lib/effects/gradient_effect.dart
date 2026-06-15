import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Sweeps a multi-color gradient across the text over time.
///
/// Each character is tinted with a color from [colors], animated so the
/// gradient shifts horizontally (or vertically) as progress increases.
/// Creates a flowing rainbow or brand-colored sweep effect.
class GradientEffect extends TextEffect {
  /// Ordered list of colors for the gradient sweep.
  final List<Color> colors;

  /// Direction of the gradient sweep (horizontal or vertical).
  final Axis direction;

  /// Creates a gradient sweep animation across characters.
  ///
  /// [duration] — one full color cycle duration.
  /// [curve] — easing curve for the sweep.
  /// [colors] — the gradient color stops in order.
  /// [direction] — sweep axis (horizontal or vertical).
  /// [delayBetweenChars] — stagger between characters.
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

  /// Generates per-character animations by shifting the gradient position
  /// based on [progress] so the color band sweeps across the text.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0 || colors.isEmpty) return [];

    return List.generate(charCount, (index) {
      // Compute each character's normalized position + progress shift.
      final t = index / (charCount - 1).clamp(1, charCount);
      final shifted = (t + progress) % 1.0;
      final color = _lerpColors(shifted);
      return CharacterAnimation(color: color);
    });
  }

  /// Linearly interpolates between [colors] at normalized position [t] (0–1).
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
