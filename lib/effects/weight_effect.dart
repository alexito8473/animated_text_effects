import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Simulates font weight animation by scaling and shifting characters.
///
/// Characters subtly widen (scaleX), change color intensity, and shift
/// position to suggest changing typographic weight, useful for emphasis
/// transitions without requiring variable fonts.
class WeightEffect extends TextEffect {
  /// Maximum horizontal scale (1.0 = normal, >1 = bolder).
  final double maxWeight;

  /// Maximum horizontal translation offset in pixels.
  final double shiftAmount;

  /// Creates a simulated weight animation.
  ///
  /// [duration] — one full weight cycle duration.
  /// [curve] — easing curve for the weight change.
  /// [maxWeight] — peak horizontal scale (1.0 = normal, 1.2 = bold).
  /// [shiftAmount] — max horizontal shift in pixels.
  /// [delayBetweenChars] — stagger (zero for simultaneous).
  const WeightEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeInOut,
    this.maxWeight = 1.15,
    this.shiftAmount = 3.0,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final t = (sin(curved * pi * 2 - pi / 2) + 1) / 2;
    final weight = 1.0 + (maxWeight - 1.0) * (curved < 0.5 ? t * t : 0.0);
    final shift = (curved < 0.5 ? (t - 0.5) : 0.0) * shiftAmount;
    final blur = curved < 0.5 ? (t - 0.5).abs() * 0.5 : 0.0;

    return List.generate(charCount, (_) {
      return CharacterAnimation(
        scaleX: weight,
        translation: Offset(shift, 0),
        blurSigma: blur,
      );
    });
  }
}
