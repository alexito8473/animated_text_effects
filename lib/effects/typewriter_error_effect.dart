import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Types incorrect characters then corrects them like a hacker movie.
///
/// Each character displays random wrong symbols before being backspaced
/// (blinking) and replaced with the correct character.
class TypewriterErrorEffect extends TextEffect {
  /// Seed for the deterministic error pattern.
  final int seed;

  /// Characters used for the error display.
  final String charset;

  /// Creates a typewriter-with-errors animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve (linear for steady typing).
  /// [delayBetweenChars] — stagger delay between characters.
  /// [seed] — seed for error pattern.
  /// [charset] — characters shown as errors.
  const TypewriterErrorEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.linear,
    super.delayBetweenChars = const Duration(milliseconds: 60),
    this.seed = 42,
    this.charset = '!@#\$%^&*()_+-=[]{}|;:,.<>?/~`',
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      const errorPhase = 0.6;
      const backspacePhase = 0.8;

      String? overrideChar;
      double opacity;

      if (curved < errorPhase) {
        final t = curved / errorPhase;
        final errorIdx = (noise(index, seed + (t * 6).floor()) * charset.length).floor();
        overrideChar = charset[errorIdx % charset.length];
        opacity = 1.0;
      } else if (curved < backspacePhase) {
        final blink = ((curved - errorPhase) / (backspacePhase - errorPhase) * 4).floor() % 2 == 0;
        overrideChar = blink ? charset[noise(index, seed).floor() % charset.length] : null;
        opacity = blink ? 0.3 : 0.0;
      } else {
        final t = (curved - backspacePhase) / (1.0 - backspacePhase);
        overrideChar = null;
        opacity = t;
      }

      return CharacterAnimation(
        character: overrideChar,
        opacity: opacity.clamp(0.0, 1.0),
        blurSigma: curved < errorPhase ? 0.0 : (1.0 - opacity) * 2.0,
      );
    });
  }
}
