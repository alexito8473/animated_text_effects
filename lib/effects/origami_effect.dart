import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Unfolds characters like origami paper, rotating from folded to flat.
///
/// Each character starts edge-on (invisible) and rotates around the Y
/// axis while simultaneously scaling from 0 in width, creating a paper
/// unfolding effect.
class OrigamiEffect extends TextEffect {
  /// Unfold direction: true = clockwise from left, false = counter-clockwise from right.
  final bool clockwise;

  /// Creates an origami fold-out reveal animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the unfold.
  /// [clockwise] — unfold direction.
  /// [delayBetweenChars] — stagger delay between characters.
  const OrigamiEffect({
    super.duration = const Duration(milliseconds: 900),
    super.curve = Curves.easeOut,
    this.clockwise = true,
    super.delayBetweenChars = const Duration(milliseconds: 40),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final dir = clockwise ? 1.0 : -1.0;
      final angle = (1.0 - curved) * pi / 2 * dir;
      final scaleX = curved.clamp(0.01, 1.0);

      return CharacterAnimation(
        rotationY: angle,
        scaleX: scaleX,
        opacity: curved.clamp(0.0, 1.0),
      );
    });
  }
}
