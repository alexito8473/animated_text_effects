import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Classic typewriter reveal animation.
///
/// Characters appear one by one from left to right. An optional blinking
/// cursor can be shown at the current typing position.
class TypewriterEffect extends TextEffect {
  /// Character displayed as the typing cursor (e.g. '|' or '_').
  final String cursor;

  /// Color of the cursor character. Uses the text style color if null.
  final Color? cursorColor;

  /// Creates a typewriter reveal animation.
  ///
  /// [duration] — total duration for the full typewrite.
  /// [curve] — easing (linear for steady typing speed).
  /// [delayBetweenChars] — time between each character typing.
  /// [cursor] — character shown as the typing cursor (e.g. '|').
  /// [cursorColor] — color of the cursor character (null = text color).
  const TypewriterEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.linear,
    super.delayBetweenChars = const Duration(milliseconds: 80),
    this.cursor = '|',
    this.cursorColor,
  });

  /// Generates per-character visibility based on typing position.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final totalDuration = getTotalDuration(charCount);
    final elapsed =
        (progress * totalDuration.inMicroseconds).toInt();
    final charDelay = delayBetweenChars.inMicroseconds;
    final charsVisible = charDelay > 0
        ? (elapsed / charDelay).floor().clamp(0, charCount)
        : (progress * charCount).round().clamp(0, charCount);

    return List.generate(charCount, (index) {
      final visible = index < charsVisible;
      return CharacterAnimation(
        opacity: visible ? 1.0 : 0.0,
        color: (cursorColor != null && index == charsVisible)
            ? cursorColor
            : null,
      );
    });
  }
}
