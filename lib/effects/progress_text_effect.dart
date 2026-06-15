import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Fills characters from left to right with a progress indicator color.
///
/// Characters switch from [emptyColor] to [filledColor] as the animation
/// progresses, creating a loading bar effect.
class ProgressTextEffect extends TextEffect {
  /// Color of characters that have been "filled" by the progress.
  final Color filledColor;

  /// Color of characters still pending.
  final Color emptyColor;

  /// Creates a binary fill animation for progress indication.
  ///
  /// [duration] — one full fill cycle duration.
  /// [curve] — easing curve for the fill rate.
  /// [filledColor] — color of filled (progressed) characters.
  /// [emptyColor] — color of pending characters.
  /// [delayBetweenChars] — stagger (zero for simultaneous fill).
  const ProgressTextEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    this.filledColor = Colors.green,
    this.emptyColor = Colors.grey,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates a left-to-right binary color fill per character.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final fillIndex = (curved * charCount).round().clamp(0, charCount);

    return List.generate(charCount, (index) {
      return CharacterAnimation(
        color: index < fillIndex ? filledColor : emptyColor,
      );
    });
  }
}
