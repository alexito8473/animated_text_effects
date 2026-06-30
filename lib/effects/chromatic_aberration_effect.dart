import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Splits each character into offset red/cyan color channels.
///
/// Characters shift horizontally with alternating red and cyan color tints,
/// simulating chromatic aberration / lens dispersion. The split amount
/// oscillates for a dynamic prismatic effect.
class ChromaticAberrationEffect extends TextEffect {
  /// Maximum horizontal displacement in logical pixels for the channel offset.
  final double splitAmount;

  /// Creates a chromatic aberration lens effect.
  ///
  /// [duration] — one full aberration cycle duration.
  /// [curve] — easing curve for the effect.
  /// [splitAmount] — max horizontal offset in pixels for channel separation.
  /// [delayBetweenChars] — stagger delay between characters.
  const ChromaticAberrationEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeInOut,
    this.splitAmount = 5.0,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final returnT = sin(curved * pi);

    return List.generate(charCount, (index) {
      final n = noise(index);
      final channel = n > 0.5;
      final offset = (n - 0.5) * splitAmount * 2 * returnT;

      return CharacterAnimation(
        translation: Offset(offset, 0),
        color: returnT > 0.001
            ? (channel ? Colors.red : Colors.cyan)
                .withValues(alpha: (0.3 + n * 0.4).clamp(0.0, 1.0))
            : null,
      );
    });
  }
}
