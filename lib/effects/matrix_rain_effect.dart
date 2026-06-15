import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters fall vertically with varying brightness like Matrix rain.
///
/// Each character drops at a slightly different rate with brightness,
/// blur, and opacity variation, emulating the iconic green rain effect.
class MatrixRainEffect extends TextEffect {
  /// Base green color for the rain (brightness varies per character).
  final Color matrixGreen;

  /// Overall fall speed multiplier (1.0 = default speed).
  final double fallSpeed;

  /// Gaussian blur applied to characters in motion.
  final double blurSigma;

  /// Creates a Matrix-style rain animation.
  ///
  /// [duration] — one full rain cycle duration.
  /// [curve] — easing (linear for constant fall speed).
  /// [matrixGreen] — base green color (brightness varies per char).
  /// [fallSpeed] — speed multiplier (1.0 = default).
  /// [blurSigma] — Gaussian blur during motion.
  /// [delayBetweenChars] — stagger (zero for varied fall).
  const MatrixRainEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.linear,
    this.matrixGreen = Colors.green,
    this.fallSpeed = 1.0,
    this.blurSigma = 2.0,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character falling animation with brightness fade.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final returnT = sin(curved * pi);

    return List.generate(charCount, (index) {
      final n = noise(index);
      final fall = (curved * fallSpeed - n * 0.3).clamp(0.0, 1.0);
      final brightness = 1.0 - fall;

      return CharacterAnimation(
        color: returnT > 0.001
            ? matrixGreen.withValues(alpha: (0.2 + brightness * 0.8).clamp(0.0, 1.0))
            : null,
        translation: Offset(0, -fall * 30.0 * returnT),
        blurSigma: blurSigma * (1.0 - brightness) * returnT,
        opacity: 1.0 + ((0.3 + brightness * 0.7) - 1.0) * returnT,
      );
    });
  }
}
