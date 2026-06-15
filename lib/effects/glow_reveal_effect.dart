import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Reveals characters with a glow-in effect: blur clears, scale shrinks
/// to normal, and opacity ramps up with a subtle pulse.
///
/// Each character starts heavily blurred and slightly enlarged, then
/// resolves to sharp, normal size with an extra glow pulse during the
/// transition. Staggered per character for a cascading reveal.
class GlowRevealEffect extends TextEffect {
  /// Starting Gaussian blur sigma at the beginning of the reveal.
  final double blurSigmaFrom;

  /// Starting scale factor (values > 1.0 enlarge the character initially).
  final double scaleFrom;

  /// Creates a glow-in reveal animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve applied to the reveal.
  /// [delayBetweenChars] — stagger delay between characters.
  /// [blurSigmaFrom] — initial blur intensity.
  /// [scaleFrom] — initial scale overshoot.
  const GlowRevealEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = const Duration(milliseconds: 30),
    this.blurSigmaFrom = 10.0,
    this.scaleFrom = 1.4,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      // Blur clears faster than scale (first 70% of progress).
      final blurT = (curved / 0.7).clamp(0.0, 1.0);
      final blur = blurSigmaFrom * (1.0 - blurT);

      // Scale normalizes within the first 60% of progress.
      final scaleT = (curved / 0.6).clamp(0.0, 1.0);
      final scale = 1.0 + (scaleFrom - 1.0) * (1.0 - scaleT);

      // Opacity ramps up quickly (first 40%).
      final opacityT = (curved / 0.4).clamp(0.0, 1.0);
      final opacity = 0.3 + 0.7 * opacityT;

      // Add a subtle sine pulse to the blur for a glowing shimmer.
      final pulse = sin(curved * pi * 2) * 0.15;
      final finalBlur = blur + pulse;

      return CharacterAnimation(
        opacity: opacity.clamp(0.0, 1.0),
        scale: scale,
        blurSigma: finalBlur.clamp(0.0, blurSigmaFrom),
      );
    });
  }
}
