import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters randomly scramble and unscramble into the final text.
///
/// Each character shows a random symbol until its reveal time, which is
/// determined by deterministic noise. The result is a sci-fi/hacker-style
/// decryption effect.
///
/// ```dart
/// ScrambleEffect(seed: 42, charset: '01')
/// ```
class ScrambleEffect extends TextEffect {
  /// Seed for the deterministic scramble pattern.
  final int seed;

  /// Characters used for the scrambled display (default: alphanumeric).
  final String charset;

  /// Creates a scramble/unscramble animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the reveal.
  /// [delayBetweenChars] — stagger delay between characters.
  /// [seed] — deterministic seed for scramble pattern.
  /// [charset] — characters used for scrambled display.
  const ScrambleEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = const Duration(milliseconds: 30),
    this.seed = 42,
    this.charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',
  });

  /// Generates per-character random char override until noise-based reveal.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final revealThreshold = noise(index, seed);
      final isRevealed = curved >= revealThreshold;

      String? overrideChar;
      if (!isRevealed) {
        final randomIndex = (noise(index, seed + 1) * charset.length).floor();
        overrideChar = charset[randomIndex % charset.length];
      }

      return CharacterAnimation(
        opacity: isRevealed ? 1.0 : 0.0,
        character: overrideChar,
      );
    });
  }
}
