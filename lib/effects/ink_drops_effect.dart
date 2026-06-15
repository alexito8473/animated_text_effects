import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters appear as if ink drops splatter across the text.
///
/// Random "drop" positions are generated deterministically via [seed].
/// Each character near a drop is revealed earlier, scaling up from small
/// to full size with blur, simulating ink spreading on paper.
class InkDropsEffect extends TextEffect {
  /// Number of ink drop centers across the text.
  final int dropCount;

  /// Distance from a drop center within which characters are affected.
  final double spreadDistance;

  /// Deterministic seed for reproducible drop positions.
  final int seed;

  /// Creates an ink splatter reveal animation.
  ///
  /// [duration] — animation cycle duration.
  /// [curve] — easing curve for the reveal.
  /// [delayBetweenChars] — stagger between characters.
  /// [dropCount] — how many drop centers to generate.
  /// [spreadDistance] — radius of effect around each drop.
  /// [seed] — random seed for reproducible drop positions.
  const InkDropsEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = Duration.zero,
    this.dropCount = 3,
    this.spreadDistance = 100.0,
    this.seed = 42,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount <= 1) return List.filled(charCount, const CharacterAnimation());
    final curved = applyCurve(progress);

    // Generate drop positions along [0, 1] using deterministic hashing.
    final drops = List.generate(dropCount, (i) {
      final h = ((seed + i * 7919) * 374761393) & 0x7FFFFFFF;
      return (h % 10000) / 10000.0;
    });

    final charPositions = List.generate(charCount, (i) => charCount > 1 ? i / (charCount - 1) : 0.5);

    return List.generate(charCount, (index) {
      final charPos = charPositions[index];

      // Find distance to nearest drop center.
      var minDist = double.infinity;
      for (final drop in drops) {
        final dist = (charPos - drop).abs();
        if (dist < minDist) minDist = dist;
      }

      // Normalize distance: 0 at drop, 1 at spreadDistance away.
      final normalizedDist = (minDist / (spreadDistance / (charCount - 1))).clamp(0.0, 1.0);

      // Character is revealed when curved progress exceeds its distance threshold.
      final revealT = ((curved - normalizedDist) / (1.0 - normalizedDist)).clamp(0.0, 1.0);

      // Scale: ink splatter starts small and grows to full size.
      final scale = 0.3 + 0.7 * revealT;
      // Opacity: fully opaque after reveal.
      final opacity = revealT;

      return CharacterAnimation(
        opacity: opacity.clamp(0.0, 1.0),
        scale: scale,
        blurSigma: (1.0 - revealT) * 2.0,
      );
    });
  }
}
