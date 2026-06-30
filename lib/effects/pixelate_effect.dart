import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters transition through block-pixel stages into their final form.
///
/// Each character resolves through a sequence of block characters
/// (full block -> dark shade -> medium shade -> light shade) as it
/// sharpens from pixelated to crisp, combined with decreasing blur.
class PixelateEffect extends TextEffect {
  /// Gaussian blur sigma when the character is most pixelated.
  final double blurSigma;

  /// Characters used for the pixel stages, ordered from most to least pixelated.
  final List<String> pixelChars;

  /// Creates a pixelated-to-sharp reveal animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the reveal.
  /// [blurSigma] — Gaussian blur at peak pixelation.
  /// [pixelChars] — pixel stage characters (default: block chars █▓▒░).
  /// [delayBetweenChars] — stagger delay between characters.
  const PixelateEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeOut,
    this.blurSigma = 3.0,
    this.pixelChars = const ['█', '▓', '▒', '░'],
    super.delayBetweenChars = const Duration(milliseconds: 30),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final stageCount = pixelChars.length;
      final rawStage = curved * stageCount;
      final stage = rawStage.floor().clamp(0, stageCount - 1);

      final pixelOpacity = curved < 0.5 ? 1.0 : (1.0 - (curved - 0.5) * 2);
      final blur = blurSigma * (1.0 - curved);

      return CharacterAnimation(
        character: curved < 1.0 ? pixelChars[stage] : null,
        opacity: curved.clamp(0.0, 1.0),
        blurSigma: blur * pixelOpacity,
        scale: 0.8 + 0.2 * curved,
      );
    });
  }
}
