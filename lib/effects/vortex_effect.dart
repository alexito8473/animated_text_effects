import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters spiral inward from orbit to their final positions.
///
/// Each character revolves around the text center in a tightening orbit,
/// combining rotation and radial contraction with a fade-in, creating
/// a vortex/tornado-like entrance.
class VortexEffect extends TextEffect {
  /// Maximum orbit radius in logical pixels.
  final double radius;

  /// Number of full revolutions during the animation.
  final int revolutions;

  /// Creates a spiral vortex entrance animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the convergence.
  /// [radius] — max orbit radius in logical pixels.
  /// [revolutions] — number of full rotations during animation.
  /// [delayBetweenChars] — stagger delay between characters.
  const VortexEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeOut,
    this.radius = 80.0,
    this.revolutions = 2,
    super.delayBetweenChars = const Duration(milliseconds: 20),
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount <= 1) return List.filled(charCount, const CharacterAnimation());

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final remaining = 1.0 - curved;
      final angleOffset = (index / charCount) * 2 * pi;
      final orbitAngle = curved * 2 * pi * revolutions + angleOffset;
      final r = radius * remaining;

      final dx = cos(orbitAngle) * r;
      final dy = sin(orbitAngle) * r;

      return CharacterAnimation(
        translation: Offset(dx, dy),
        opacity: curved.clamp(0.0, 1.0),
        rotation: -remaining * pi * 0.5,
      );
    });
  }
}
