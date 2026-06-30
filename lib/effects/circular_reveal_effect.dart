import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Reveals characters in a circular wave radiating from the center.
///
/// Characters near the center of the text appear first, with the reveal
/// propagating outward in concentric rings using scale and opacity.
class CircularRevealEffect extends TextEffect {
  /// How many ring steps from center to edge.
  final int rings;

  /// Starting scale before reveal (0.0 = invisible).
  final double scaleFrom;

  /// If true, reveals from the edges inward instead of center outward.
  final bool inward;

  /// Creates a circular wave reveal animation.
  ///
  /// [duration] — one full reveal cycle duration.
  /// [curve] — easing curve for the reveal.
  /// [rings] — number of concentric reveal rings.
  /// [scaleFrom] — starting scale before reveal.
  /// [inward] — reveal from edges inward instead of center outward.
  /// [delayBetweenChars] — stagger (zero for distance-based timing).
  const CircularRevealEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeOut,
    this.rings = 3,
    this.scaleFrom = 0.0,
    this.inward = false,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount <= 1) return List.filled(charCount, const CharacterAnimation());

    final curved = applyCurve(progress);
    final center = (charCount - 1) / 2.0;

    return List.generate(charCount, (index) {
      final dist = (index - center).abs() / center;
      final effectiveDist = inward ? (1.0 - dist) : dist;
      final ringThreshold = (effectiveDist * rings / (rings + 1));
      final localProgress = ((curved - ringThreshold) / (1.0 - ringThreshold)).clamp(0.0, 1.0);
      final eased = localProgress * (2.0 - localProgress);

      return CharacterAnimation(
        opacity: eased.clamp(0.0, 1.0),
        scale: scaleFrom + (1.0 - scaleFrom) * eased,
        blurSigma: (1.0 - eased) * 2.0,
      );
    });
  }
}
