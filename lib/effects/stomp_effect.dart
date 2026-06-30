import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters drop from above, impact with a squash, and settle.
///
/// Each character falls vertically, compresses (squash) on hitting the
/// ground, stretches (stretch), and finally settles at rest.
class StompEffect extends TextEffect {
  /// Drop height in logical pixels.
  final double dropHeight;

  /// Squash scale factor at impact (0.0–1.0).
  final double squashAmount;

  /// Creates a stomp/impact entrance animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve (elasticOut recommended).
  /// [dropHeight] — fall distance in logical pixels.
  /// [squashAmount] — vertical compression on impact (0 = full squash).
  /// [delayBetweenChars] — stagger delay between characters.
  const StompEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.elasticOut,
    this.dropHeight = 100.0,
    this.squashAmount = 0.3,
    super.delayBetweenChars = const Duration(milliseconds: 60),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final impact = 0.65;
      double dy, scaleY, scaleX;

      if (curved < impact) {
        final t = curved / impact;
        dy = -dropHeight * (1.0 - t);
        scaleY = 1.0;
        scaleX = 1.0;
      } else if (curved < impact + 0.08) {
        final t = (curved - impact) / 0.08;
        final squash = 1.0 - (1.0 - squashAmount) * sin(t * pi);
        dy = 0;
        scaleY = squash;
        scaleX = 1.0 / squash;
      } else if (curved < impact + 0.18) {
        final t = (curved - impact - 0.08) / 0.1;
        final stretch = 1.0 + (1.0 - squashAmount) * 0.3 * sin(t * pi);
        dy = -8.0 * sin(t * pi);
        scaleY = stretch;
        scaleX = 1.0 / stretch;
      } else {
        dy = 0;
        scaleY = 1.0;
        scaleX = 1.0;
      }

      return CharacterAnimation(
        translation: Offset(0, dy),
        scaleY: scaleY.clamp(0.05, 3.0),
        scaleX: scaleX.clamp(0.05, 3.0),
        opacity: curved.clamp(0.0, 1.0),
      );
    });
  }
}
