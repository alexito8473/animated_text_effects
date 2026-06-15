import 'package:flutter/material.dart';
import 'character_animation.dart';

/// Base class for all text animation effects.
///
/// Subclasses implement [getAnimations] to produce per-character animation
/// data for a given global progress value. Effects are stateless and pure:
/// the same inputs always produce the same output, enabling composition
/// via [CharacterAnimation.combine].
///
/// Every effect guarantees that `f(0) == f(1)`, meaning characters return to
/// their identity state at both extremes for seamless looping.
abstract class TextEffect {
  /// Total duration of one full animation cycle for a single character.
  final Duration duration;

  /// Curve applied to the animation timing for easing.
  final Curve curve;

  /// Delay between each successive character's animation start.
  final Duration delayBetweenChars;

  /// Creates a [TextEffect] with configurable timing.
  ///
  /// [duration] — total animation cycle time per character.
  /// [curve] — easing curve applied to animation timing.
  /// [delayBetweenChars] — stagger offset between successive characters.
  const TextEffect({
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeInOut,
    this.delayBetweenChars = Duration.zero,
  });

  /// Returns the total duration needed to animate all [charCount] characters.
  ///
  /// [charCount] — number of characters in the text.
  Duration getTotalDuration(int charCount) {
    return duration + delayBetweenChars * charCount;
  }

  /// Produces a list of per-character animations for the given [progress].
  ///
  /// [progress] ranges from 0.0 (start) to 1.0 (end). The returned list
  /// must have exactly [charCount] elements.
  List<CharacterAnimation> getAnimations(double progress, int charCount);

  /// Applies the effect's [curve] to a linear value [t] (0.0–1.0).
  ///
  /// [t] — raw linear progress to transform through the curve.
  double applyCurve(double t) {
    return curve.transform(t.clamp(0.0, 1.0));
  }

  /// Computes the per-character progress for staggered animations.
  ///
  /// Given a [globalProgress] (0.0–1.0), returns the individual progress
  /// for character at [index] out of [charCount] total characters.
  ///
  /// [globalProgress] — overall animation progress from 0.0 to 1.0.
  /// [index] — zero-based index of the character.
  /// [charCount] — total number of characters.
  double staggeredProgress(double globalProgress, int index, int charCount) {
    if (charCount <= 1) return globalProgress;
    final total = duration + delayBetweenChars * charCount;
    if (total.inMicroseconds == 0) return 1.0;
    final charStart = (delayBetweenChars * index).inMicroseconds / total.inMicroseconds;
    final charDuration = duration.inMicroseconds / total.inMicroseconds;
    final t = (globalProgress - charStart) / charDuration;
    return t.clamp(0.0, 1.0);
  }

  /// Returns a deterministic pseudo-random value (0.0–1.0) for the given
  /// [index] and optional [offset].
  ///
  /// Uses a hash-based function instead of [Random] so results are
  /// reproducible across runs.
  ///
  /// [index] — primary seed for the noise value.
  /// [offset] — secondary offset for multi-frequency noise.
  double noise(int index, [int offset = 0]) {
    final h = (index * 374761393 + offset * 668265263) & 0x7FFFFFFF;
    return (h % 10000) / 10000.0;
  }
}
