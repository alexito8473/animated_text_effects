import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Simulates VHS tape distortion with scan lines, jitter, and color shift.
///
/// Uses multi-frequency noise to randomly trigger horizontal jitter,
/// color offset, blur, and opacity dips on individual characters.
class VHSGlitchEffect extends TextEffect {
  /// Maximum horizontal jitter displacement in pixels.
  final double jitter;

  /// Horizontal color channel offset in pixels during glitch.
  final double colorOffset;

  /// Maximum Gaussian blur during glitch events.
  final double maxBlur;

  /// Creates a VHS-style glitch distortion effect.
  ///
  /// [duration] — one full glitch pattern duration.
  /// [curve] — easing (linear for instant glitch transitions).
  /// [jitter] — max horizontal jitter displacement in pixels.
  /// [colorOffset] — horizontal color channel offset during glitch.
  /// [maxBlur] — maximum Gaussian blur during glitch events.
  /// [delayBetweenChars] — stagger (zero for random glitch).
  const VHSGlitchEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.linear,
    this.jitter = 8.0,
    this.colorOffset = 4.0,
    this.maxBlur = 1.5,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character glitch with jitter, color shift, and blur.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final t = curved * duration.inMicroseconds / 1000000.0;

    return List.generate(charCount, (index) {
      final n = noise(index, (t * 12).floor());
      final n2 = noise(index, (t * 8).floor() + 50);
      final returnT = sin(curved * pi);
      final hasGlitch = n > 0.7;

      final dx = (hasGlitch ? (n2 - 0.5) * jitter : 0.0) * returnT;
      final colorShift = (hasGlitch ? colorOffset : 0.0) * returnT;
      final blur = (hasGlitch ? maxBlur * n2 : 0.0) * returnT;
      final opacity = 1.0 - (hasGlitch ? 0.15 : 0.0) * returnT;

      return CharacterAnimation(
        translation: Offset(dx + colorShift, 0),
        blurSigma: blur,
        opacity: opacity.clamp(0.0, 1.0),
        color: hasGlitch && returnT > 0.001
            ? Colors.cyan.withValues(alpha: 0.3 * returnT)
            : null,
      );
    });
  }
}
