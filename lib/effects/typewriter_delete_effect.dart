import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Types text forward then deletes it backward character by character.
///
/// The full text is typed from left to right, then deleted from right
/// to left in a continuous loop, like a command line prompt cycling.
class TypewriterDeleteEffect extends TextEffect {
  /// Character displayed as the cursor during typing/deleting.
  final String cursor;

  /// Color of the cursor character.
  final Color? cursorColor;

  /// Fraction of the animation spent typing (0.0–1.0).
  final double typeFraction;

  /// Creates a type-then-delete loop animation.
  ///
  /// [duration] — one full type+delete cycle duration.
  /// [curve] — easing curve (linear for steady speed).
  /// [delayBetweenChars] — stagger (zero — timing is driven by progress).
  /// [cursor] — cursor character shown at the active position.
  /// [cursorColor] — color of the cursor.
  /// [typeFraction] — portion of animation spent typing (rest is delete).
  const TypewriterDeleteEffect({
    super.duration = const Duration(milliseconds: 3000),
    super.curve = Curves.linear,
    super.delayBetweenChars = Duration.zero,
    this.cursor = '|',
    this.cursorColor,
    this.typeFraction = 0.5,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final total = charCount.toDouble();
    final typeCursorPos = (curved / typeFraction * total).floor().clamp(0, charCount);
    final deleteProgress = ((curved - typeFraction) / (1.0 - typeFraction)).clamp(0.0, 1.0);
    final deleteCursorPos = (deleteProgress * total).floor().clamp(0, charCount);

    const holdFraction = 0.05;
    final showingAll = curved > 1.0 - holdFraction;

    return List.generate(charCount, (index) {
      final isTypingPhase = curved <= typeFraction;
      final visible = showingAll || (isTypingPhase
          ? index < typeCursorPos
          : index < charCount - deleteCursorPos);
      final isCursor = !showingAll && (isTypingPhase
          ? index == typeCursorPos
          : index == charCount - deleteCursorPos - 1);

      return CharacterAnimation(
        opacity: visible ? 1.0 : 0.0,
        character: isCursor ? cursor : null,
        color: isCursor ? cursorColor : null,
      );
    });
  }
}
