import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class TypewriterEffect extends TextEffect {
  final String cursor;
  final Color? cursorColor;

  const TypewriterEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.linear,
    super.delayBetweenChars = const Duration(milliseconds: 80),
    this.cursor = '|',
    this.cursorColor,
  });

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
