import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters drift upward and fade out like rising smoke.
///
/// Each character rises, blurs, and loses opacity, with a random
/// horizontal drift for a smoky, ethereal effect.
class SmokeEffect extends TextEffect {
  /// Maximum upward travel distance in logical pixels.
  final double height;

  /// Gaussian blur applied as the character fades.
  final double blurSigma;

  /// Creates a smoke-rising animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the ascent.
  /// [height] — max upward travel distance in pixels.
  /// [blurSigma] — Gaussian blur as character fades.
  /// [delayBetweenChars] — stagger delay between characters.
  const SmokeEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeOut,
    this.height = 40.0,
    this.blurSigma = 6.0,
    super.delayBetweenChars = const Duration(milliseconds: 50),
  });

  /// Generates per-character upward drift, blur, and opacity fade.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final returnT = sin(curved * pi);

      final n = noise(index);
      final dx = (n - 0.5) * 30.0 * returnT;
      final dy = -height * returnT;
      final opacity = 1.0 - returnT;
      final blur = blurSigma * returnT;

      return CharacterAnimation(
        translation: Offset(dx, dy),
        opacity: opacity.clamp(0.0, 1.0),
        blurSigma: blur,
      );
    });
  }
}
