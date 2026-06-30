import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters cycle through digits/symbols like a countdown timer.
///
/// Each character rapidly rolls through numeric or alphanumeric symbols
/// before landing on the final character, creating a retro countdown or
/// slot-machine reveal effect.
class CountdownEffect extends TextEffect {
  /// Seed for the deterministic cycle pattern.
  final int seed;

  /// Characters to cycle through during the countdown.
  final String charset;

  /// Creates a countdown / slot-machine roll effect.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the settle.
  /// [delayBetweenChars] — stagger delay between characters.
  /// [seed] — deterministic seed for the cycle order.
  /// [charset] — characters shown during the countdown cycle.
  const CountdownEffect({
    super.duration = const Duration(milliseconds: 1800),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = const Duration(milliseconds: 40),
    this.seed = 42,
    this.charset = '0123456789ABCDEF',
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final rollSpeed = 4.0;
      final settleAt = 0.85;
      String? overrideChar;

      if (curved < settleAt) {
        final roll = (curved * rollSpeed * charset.length).floor();
        final cycleIdx = (roll + noise(index, seed) * charset.length).floor() % charset.length;
        overrideChar = charset[cycleIdx];
      } else {
        overrideChar = null;
      }

      final opacity = curved < 0.05 ? curved / 0.05 : 1.0;

      return CharacterAnimation(
        character: overrideChar,
        opacity: opacity.clamp(0.0, 1.0),
        scaleY: curved < settleAt
            ? 0.7 + 0.3 * sin(curved * rollSpeed * pi * 2)
            : 1.0,
      );
    });
  }
}
