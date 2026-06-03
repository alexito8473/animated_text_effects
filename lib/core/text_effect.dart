import 'package:flutter/material.dart';
import 'character_animation.dart';

abstract class TextEffect {
  final Duration duration;
  final Curve curve;
  final Duration delayBetweenChars;

  const TextEffect({
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeInOut,
    this.delayBetweenChars = Duration.zero,
  });

  Duration getTotalDuration(int charCount) {
    return duration + delayBetweenChars * charCount;
  }

  List<CharacterAnimation> getAnimations(double progress, int charCount);

  double applyCurve(double t) {
    return curve.transform(t).clamp(0.0, 1.0);
  }

  double staggeredProgress(double globalProgress, int index, int charCount) {
    if (charCount <= 1) return globalProgress;
    final total = duration + delayBetweenChars * charCount;
    if (total.inMicroseconds == 0) return 1.0;
    final charStart = (delayBetweenChars * index).inMicroseconds / total.inMicroseconds;
    final charDuration = duration.inMicroseconds / total.inMicroseconds;
    final t = (globalProgress - charStart) / charDuration;
    return t.clamp(0.0, 1.0);
  }

  double noise(int index, [int offset = 0]) {
    final h = (index * 374761393 + offset * 668265263) & 0x7FFFFFFF;
    return (h % 10000) / 10000.0;
  }
}
