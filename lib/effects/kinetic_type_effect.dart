import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Applies a kinetic energy wave: characters bounce, rotate, and scale
/// as a sinusoidal wave travels through the text.
///
/// All characters oscillate in unison with a traveling phase offset,
/// creating an energetic, physics-like motion. Uses [Curves.linear] by
/// default so the wave motion is continuous rather than eased.
class KineticTypeEffect extends TextEffect {
  /// Vertical displacement amplitude in logical pixels.
  final double amplitude;

  /// Number of complete wave cycles across the text.
  final double waveCount;

  /// Maximum rotation angle in radians from the wave.
  final double rotationAmplitude;

  /// Creates a kinetic wave animation.
  ///
  /// [duration] — one full wave cycle duration.
  /// [curve] — easing curve (linear recommended for continuous motion).
  /// [delayBetweenChars] — stagger between characters.
  /// [amplitude] — vertical bounce height.
  /// [waveCount] — number of waves across the text.
  /// [rotationAmplitude] — rotation intensity per character.
  const KineticTypeEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.linear,
    super.delayBetweenChars = Duration.zero,
    this.amplitude = 4.0,
    this.waveCount = 2.0,
    this.rotationAmplitude = 0.03,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount <= 1) return List.filled(charCount, const CharacterAnimation());
    final phase = progress * 2 * pi;

    return List.generate(charCount, (index) {
      final charPhase = (index / (charCount - 1)) * waveCount * 2 * pi;
      final wave = sin(charPhase + phase);

      final y = wave * amplitude;
      final rot = wave * rotationAmplitude;
      final s = 1.0 + wave * 0.03;

      return CharacterAnimation(
        translation: Offset(0, y),
        rotation: rot,
        scale: s,
      );
    });
  }
}
