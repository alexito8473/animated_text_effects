import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters drift down like falling leaves, swaying side to side.
///
/// Each character descends from above with a sinusoidal horizontal sway,
/// gentle rotation, and a slight scale wobble, emulating leaves floating
/// to the ground.
class FallingLeavesEffect extends TextEffect {
  /// Maximum sway amplitude in logical pixels.
  final double swayAmplitude;

  /// Fall distance in logical pixels.
  final double fallDistance;

  /// Maximum rotation amplitude in radians.
  final double rotationAmplitude;

  /// Creates a falling leaves animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the descent.
  /// [swayAmplitude] — horizontal sway in pixels.
  /// [fallDistance] — vertical fall in pixels.
  /// [rotationAmplitude] — max rotation in radians.
  /// [delayBetweenChars] — stagger delay between characters.
  const FallingLeavesEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.easeIn,
    this.swayAmplitude = 20.0,
    this.fallDistance = 80.0,
    this.rotationAmplitude = 0.3,
    super.delayBetweenChars = const Duration(milliseconds: 80),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final remaining = 1.0 - curved;
      final phase = noise(index) * 2 * pi;
      final sway = sin(curved * 4 * pi + phase) * swayAmplitude * remaining;
      final dy = -fallDistance * remaining;
      final rot = sin(curved * 3 * pi + phase) * rotationAmplitude * remaining;
      final s = 1.0 + sin(curved * 2 * pi + phase) * 0.1 * remaining;

      return CharacterAnimation(
        translation: Offset(sway, dy),
        rotation: rot,
        scale: s,
        opacity: (1.0 - remaining * 0.5).clamp(0.0, 1.0),
      );
    });
  }
}
