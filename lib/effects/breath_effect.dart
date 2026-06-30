import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// A full breathing cycle with combined scale, opacity, blur, and color
/// shift. Characters expand, brighten, sharpen on inhale and contract,
/// dim, blur on exhale, creating a more organic breath than the simpler
/// [BreathingOpacityEffect].
class BreathEffect extends TextEffect {
  /// Scale at the exhale trough (1.0 = normal size).
  final double scaleMin;

  /// Scale at the inhale peak.
  final double scaleMax;

  /// Minimum opacity during exhale.
  final double opacityMin;

  /// Gaussian blur at the exhale trough.
  final double blurSigma;

  /// Creates a full breathing animation.
  ///
  /// [duration] — one full breath cycle (inhale + exhale).
  /// [curve] — easing curve for the breath.
  /// [scaleMin] — scale at exhale trough.
  /// [scaleMax] — scale at inhale peak.
  /// [opacityMin] — opacity during exhale.
  /// [blurSigma] — blur during exhale.
  /// [delayBetweenChars] — stagger (zero for simultaneous breath).
  const BreathEffect({
    super.duration = const Duration(milliseconds: 3000),
    super.curve = Curves.easeInOut,
    this.scaleMin = 0.92,
    this.scaleMax = 1.08,
    this.opacityMin = 0.85,
    this.blurSigma = 1.5,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final t = sin(curved * 2 * pi);
    final normalized = ((t + 1) / 2 * 2 - 1).clamp(-1.0, 1.0);

    final s = 1.0 + (normalized > 0
        ? (scaleMax - 1.0) * normalized
        : (1.0 - scaleMin) * normalized);
    final op = 1.0 + (normalized > 0
        ? (1.0 - opacityMin) * normalized * 0.3 * -1
        : (opacityMin - 1.0) * normalized.abs());
    final blur = normalized < 0
        ? blurSigma * normalized.abs()
        : 0.0;

    return List.generate(charCount, (_) {
      return CharacterAnimation(
        scale: s,
        opacity: op.clamp(0.0, 1.0),
        blurSigma: blur,
      );
    });
  }
}
