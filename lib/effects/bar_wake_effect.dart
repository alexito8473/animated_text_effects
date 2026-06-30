import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// A progress bar sweeps across, leaving characters lit in its wake.
///
/// Characters ahead of the bar are dim, those behind are brightly colored
/// with a pulsing afterglow. Creates a loading / progress bar effect.
class BarWakeEffect extends TextEffect {
  /// Color of characters after the bar passes.
  final Color filledColor;

  /// Color of characters ahead of the bar.
  final Color emptyColor;

  /// Width of the active bar as a fraction of character count.
  final double barWidth;

  /// Intensity of the pulsing afterglow (0.0–1.0).
  final double wakeGlow;

  /// Creates a bar wake / progress effect.
  ///
  /// [duration] — one full sweep duration.
  /// [curve] — easing curve for the sweep.
  /// [filledColor] — color after bar passes.
  /// [emptyColor] — color ahead of bar.
  /// [barWidth] — bar width as fraction of text.
  /// [wakeGlow] — afterglow intensity (0–1).
  /// [delayBetweenChars] — stagger (zero for smooth sweep).
  const BarWakeEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.filledColor = Colors.green,
    this.emptyColor = Colors.grey,
    this.barWidth = 0.2,
    this.wakeGlow = 0.3,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final barLeading = (curved * charCount).round();

    return List.generate(charCount, (index) {
      if (curved >= 0.995) {
        return const CharacterAnimation();
      }
      if (index < barLeading) {
        final behindDist = (barLeading - index) / charCount;
        final pulse = wakeGlow * 0.5 * (1.0 + sin(curved * 4 * pi - index * 0.5));
        final alpha = (1.0 - behindDist * pulse).clamp(0.4, 1.0);
        return CharacterAnimation(
          color: filledColor.withValues(alpha: alpha),
        );
      } else if (index < barLeading + (barWidth * charCount).round()) {
        return CharacterAnimation(
          color: filledColor.withValues(alpha: 0.8 + 0.2 * sin(curved * 6 * pi)),
          scale: 1.0 + 0.05 * sin(curved * 6 * pi),
        );
      } else {
        return CharacterAnimation(color: emptyColor);
      }
    });
  }
}
