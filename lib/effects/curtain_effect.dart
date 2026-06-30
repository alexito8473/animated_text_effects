import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Reveals text like curtains parting from the center.
///
/// Characters slide outward from the center of the text — left-half
/// characters move left, right-half characters move right — creating
/// a theatrical curtain opening effect.
class CurtainEffect extends TextEffect {
  /// Maximum travel distance from center in logical pixels.
  final double distance;

  /// Creates a curtain reveal animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the slide.
  /// [distance] — max travel distance in logical pixels.
  /// [delayBetweenChars] — stagger (zero for simultaneous motion).
  const CurtainEffect({
    super.duration = const Duration(milliseconds: 800),
    super.curve = Curves.easeOut,
    this.distance = 60.0,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount <= 1) return List.filled(charCount, const CharacterAnimation());

    final curved = applyCurve(progress);
    final remaining = 1.0 - curved;
    final center = (charCount - 1) / 2.0;

    return List.generate(charCount, (index) {
      final dir = index < center ? -1.0 : (index > center ? 1.0 : 0.0);
      final dist = (index - center).abs() / center;
      final dx = dir * distance * dist * remaining;

      return CharacterAnimation(
        translation: Offset(dx, 0),
        opacity: (1.0 - remaining * 0.3).clamp(0.0, 1.0),
      );
    });
  }
}
