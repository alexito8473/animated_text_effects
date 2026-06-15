import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Rhythmic scale and opacity pulsing across all characters.
///
/// All characters pulse in unison, oscillating between [scaleMin]/[scaleMax]
/// and [opacityMin]/1.0, like a heartbeat or breathing indicator.
class PulseEffect extends TextEffect {
  /// Minimum scale factor at the pulse trough.
  final double scaleMin;

  /// Maximum scale factor at the pulse peak.
  final double scaleMax;

  /// Minimum opacity during the pulse cycle.
  final double opacityMin;

  /// Creates a pulsing scale and opacity animation.
  ///
  /// [duration] — one full pulse duration.
  /// [curve] — easing curve for the pulse.
  /// [scaleMin] — minimum scale at pulse trough.
  /// [scaleMax] — maximum scale at pulse peak.
  /// [opacityMin] — minimum opacity during pulse.
  /// [delayBetweenChars] — stagger (zero for simultaneous pulse).
  const PulseEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeInOut,
    this.scaleMin = 1.0,
    this.scaleMax = 1.3,
    this.opacityMin = 0.85,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates uniform scale/opacity pulse across all characters.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final normalized = sin(curved * pi);

    final scale = scaleMin + (scaleMax - scaleMin) * normalized;
    final opacity = opacityMin + (1.0 - opacityMin) * (1.0 - normalized * 0.5);

    return List.generate(charCount, (_) {
      return CharacterAnimation(
        scale: scale,
        opacity: opacity,
      );
    });
  }
}
