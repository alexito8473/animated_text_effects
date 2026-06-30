import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Tiny glowing dots float and coalesce into the text like fireflies.
///
/// Characters start as small, colored, blurred dots scattered randomly
/// that drift to their final positions while brightening and sharpening.
class FirefliesEffect extends TextEffect {
  /// Color of the firefly glow.
  final Color glowColor;

  /// Maximum drift radius in logical pixels.
  final double driftRadius;

  /// Creates a fireflies/particles coalesce animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for convergence.
  /// [glowColor] — color of the firefly glow.
  /// [driftRadius] — max drift radius in pixels.
  /// [delayBetweenChars] — stagger (zero for random convergence).
  const FirefliesEffect({
    super.duration = const Duration(milliseconds: 2500),
    super.curve = Curves.easeOut,
    this.glowColor = Colors.amber,
    this.driftRadius = 100.0,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final returnT = sin(curved * pi);

    return List.generate(charCount, (index) {
      final n = noise(index);
      final n2 = noise(index, 1);

      final remaining = 1.0 - curved;
      final dx = (n - 0.5) * 2 * driftRadius * remaining;
      final dy = (n2 - 0.5) * 2 * driftRadius * remaining;
      final wobble = sin(curved * 6 * pi + n * 2 * pi) * 5.0 * remaining;
      final wobbleY = cos(curved * 5 * pi + n2 * 2 * pi) * 5.0 * remaining;
      final brightness = 0.3 + 0.7 * curved;
      final opacity = (0.2 + 0.8 * curved).clamp(0.0, 1.0);
      final s = 0.3 + 0.7 * curved;

      return CharacterAnimation(
        character: curved < 0.8 ? '·' : null,
        translation: Offset(dx + wobble, dy + wobbleY),
        color: returnT > 0.001
            ? glowColor.withValues(alpha: (brightness * opacity).clamp(0.0, 1.0))
            : null,
        opacity: opacity,
        scale: s,
        blurSigma: (1.0 - curved) * 4.0,
      );
    });
  }
}
