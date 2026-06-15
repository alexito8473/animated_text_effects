import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters appear in random order, each at a unique reveal time.
///
/// Unlike [FadeEffect] which reveals left-to-right, this effect assigns
/// each character a random reveal threshold via deterministic noise,
/// creating a scattered, organic appear pattern.
///
/// ```dart
/// RandomRevealEffect(seed: 42, opacityFrom: 0.0)
/// ```
class RandomRevealEffect extends TextEffect {
  /// Seed for the random reveal order.
  final int seed;

  /// Starting opacity before the character is revealed.
  final double opacityFrom;

  /// Creates a random-order reveal animation.
  ///
  /// [duration] — animation cycle duration.
  /// [curve] — easing curve for each character's reveal.
  /// [seed] — deterministic seed for reveal order.
  /// [opacityFrom] — starting opacity before reveal.
  /// [delayBetweenChars] — stagger (zero — order determined by noise).
  const RandomRevealEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeOut,
    this.seed = 42,
    this.opacityFrom = 0.0,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character reveals triggered by noise thresholds.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      final revealAt = noise(index, seed);
      final localProgress = ((curved - revealAt) / (1.0 - revealAt)).clamp(0.0, 1.0);
      final eased = localProgress * (2.0 - localProgress);
      final fadeOpacity = opacityFrom + (1.0 - opacityFrom) * eased;

      return CharacterAnimation(
        opacity: fadeOpacity.clamp(0.0, 1.0),
        scale: opacityFrom + (1.0 - opacityFrom) * eased,
      );
    });
  }
}
