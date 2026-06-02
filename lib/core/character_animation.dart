import 'package:flutter/painting.dart';

class CharacterAnimation {
  final double opacity;
  final Offset translation;
  final double scale;
  final Color? color;
  final double blurSigma;

  const CharacterAnimation({
    this.opacity = 1.0,
    this.translation = Offset.zero,
    this.scale = 1.0,
    this.color,
    this.blurSigma = 0.0,
  });

  CharacterAnimation combine(CharacterAnimation other) {
    return CharacterAnimation(
      opacity: opacity * other.opacity,
      translation: translation + other.translation,
      scale: scale * other.scale,
      color: other.color ?? color,
      blurSigma: blurSigma + other.blurSigma,
    );
  }
}
