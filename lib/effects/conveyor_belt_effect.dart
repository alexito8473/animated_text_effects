import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters scroll horizontally in a loop like a conveyor belt.
///
/// Each character translates horizontally with configurable [spacing],
/// creating a scrolling marquee or belt effect. Set [reverse] to flip
/// the scroll direction.
class ConveyorBeltEffect extends TextEffect {
  /// Horizontal spacing between character positions in pixels.
  final double spacing;

  /// When true, characters scroll rightward instead of leftward.
  final bool reverse;

  /// Creates a conveyor belt scrolling animation.
  ///
  /// [duration] — one full scroll cycle duration.
  /// [curve] — easing curve for the scroll.
  /// [spacing] — horizontal gap between characters in pixels.
  /// [reverse] — when true, scrolls rightward instead of leftward.
  /// [delayBetweenChars] — stagger (zero for synchronized scroll).
  const ConveyorBeltEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.easeInOut,
    this.spacing = 30.0,
    this.reverse = false,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character horizontal translation for the belt scroll.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final returnT = sin(curved * pi);
    final dir = reverse ? 1.0 : -1.0;

    return List.generate(charCount, (index) {
      final dx = (index.toDouble() + curved) * spacing * returnT * dir;
      return CharacterAnimation(translation: Offset(dx, 0));
    });
  }
}
