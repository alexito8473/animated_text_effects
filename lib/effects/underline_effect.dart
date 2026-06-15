import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Draws an animated underline beneath each character.
///
/// The underline grows from left to right per character, with configurable
/// [lineColor] and underline [height].
class UnderlineEffect extends TextEffect {
  /// Color of the underline. Defaults to the text color if null.
  final Color? lineColor;

  /// Thickness of the underline in logical pixels.
  final double height;

  /// Creates an underline drawing animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for underline draw.
  /// [lineColor] — underline color (null = text color).
  /// [height] — underline thickness in pixels.
  /// [delayBetweenChars] — stagger delay between characters.
  const UnderlineEffect({
    super.duration = const Duration(milliseconds: 600),
    super.curve = Curves.easeOut,
    this.lineColor,
    this.height = 2.0,
    super.delayBetweenChars = const Duration(milliseconds: 30),
  });

  /// Generates per-character underline progress animations.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final returnT = sin(curved * pi);
      return CharacterAnimation(
        underlineProgress: returnT,
        color: lineColor,
      );
    });
  }
}
