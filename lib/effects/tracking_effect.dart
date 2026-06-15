import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Spreads characters apart horizontally like adjustable letter-spacing.
///
/// Characters move outward from the center (or from the left edge when
/// [fromCenter] is false) by [spacing] pixels, creating a tracking/tracking-in
/// animation. Useful for title reveals where letters spread into position.
class TrackingEffect extends TextEffect {
  /// Final horizontal distance between adjacent character centers in pixels.
  final double spacing;

  /// When true, characters spread outward symmetrically from the text center.
  /// When false, characters spread rightward from the first character.
  final bool fromCenter;

  /// Creates a tracking/spacing animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve applied to the spread motion.
  /// [delayBetweenChars] — stagger between characters (zero = unison).
  /// [spacing] — horizontal spread distance between characters.
  /// [fromCenter] — spread from center (true) or from left edge (false).
  const TrackingEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = Duration.zero,
    this.spacing = 30.0,
    this.fromCenter = true,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount <= 1) return List.filled(charCount, const CharacterAnimation());
    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      double dx;
      if (fromCenter) {
        // Spread outward symmetrically from the center character.
        final center = (charCount - 1) / 2.0;
        final offset = index - center;
        dx = offset * spacing * curved;
      } else {
        // Spread rightward from the first character.
        dx = index * spacing * curved / (charCount - 1);
      }
      return CharacterAnimation(translation: Offset(dx, 0));
    });
  }
}
