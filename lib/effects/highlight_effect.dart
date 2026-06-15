import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Sweeps a background highlight color behind each character.
///
/// Characters are highlighted sequentially with the given [highlightColor],
/// fading from [opacityFrom] to [opacityTo] for a marker-like effect.
class HighlightEffect extends TextEffect {
  /// Background color used for the highlight.
  final Color highlightColor;

  /// Starting opacity of the highlight.
  final double opacityFrom;

  /// Peak opacity of the highlight.
  final double opacityTo;

  /// Creates a highlight sweep animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the highlight.
  /// [highlightColor] — background color for the highlight.
  /// [opacityFrom] — starting highlight opacity.
  /// [opacityTo] — peak highlight opacity.
  /// [delayBetweenChars] — stagger delay between characters.
  const HighlightEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeInOut,
    this.highlightColor = Colors.yellow,
    this.opacityFrom = 0.0,
    this.opacityTo = 0.6,
    super.delayBetweenChars = const Duration(milliseconds: 40),
  });

  /// Generates per-character background color sweeps.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final returnT = sin(curved * pi);
      final bgOpacity = opacityFrom + (opacityTo - opacityFrom) * returnT;
      return CharacterAnimation(
        backgroundColor: bgOpacity > 0.001
            ? highlightColor.withValues(alpha: bgOpacity.clamp(0.0, 1.0))
            : null,
      );
    });
  }
}
