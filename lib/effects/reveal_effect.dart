import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Reveals each character progressively using a clip mask.
///
/// Characters are clipped from [clipFrom] to 1.0, creating a wipe or
/// curtain reveal effect.
class RevealEffect extends TextEffect {
  /// Unused (reserved for future horizontal/vertical clip axis).
  final bool horizontal;

  /// Starting clip progress (0.0 = hidden, 1.0 = fully visible).
  final double clipFrom;

  /// Creates a clip-based reveal animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the clip reveal.
  /// [horizontal] — reserved for future axis selection.
  /// [clipFrom] — starting clip progress (0 = hidden, 1 = visible).
  /// [delayBetweenChars] — stagger delay between characters.
  const RevealEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeOut,
    this.horizontal = true,
    this.clipFrom = 0.0,
    super.delayBetweenChars = const Duration(milliseconds: 30),
  });

  /// Generates per-character clip reveal from [clipFrom] to 1.0.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final clip = clipFrom + (1.0 - clipFrom) * curved;
      return CharacterAnimation(clipProgress: clip.clamp(0.0, 1.0));
    });
  }
}
