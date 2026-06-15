import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Slow, rhythmic opacity pulse across all characters in unison.
///
/// All characters fade together between [opacityMin] and 1.0,
/// simulating a breathing or sleeping pattern.
class BreathingOpacityEffect extends TextEffect {
  /// Minimum opacity at the trough of the breath cycle.
  final double opacityMin;

  /// Creates a breathing opacity animation.
  ///
  /// [duration] — one full breath cycle duration.
  /// [curve] — easing curve for the fade.
  /// [opacityMin] — minimum opacity at the trough of the breath.
  /// [delayBetweenChars] — stagger (zero for unison breathing).
  const BreathingOpacityEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.easeInOut,
    this.opacityMin = 0.7,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates a uniform opacity pulse across all characters.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final t = sin(curved * pi);
    final opacity = 1.0 - (1.0 - opacityMin) * t;

    return List.generate(charCount, (_) {
      return CharacterAnimation(opacity: opacity);
    });
  }
}
