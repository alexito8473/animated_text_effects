import 'package:flutter/painting.dart';

class CharacterAnimation {
  final double opacity;
  final Offset translation;
  final double scale;
  final double scaleX;
  final double scaleY;
  final Color? color;
  final Color? backgroundColor;
  final double blurSigma;
  final double rotation;
  final double rotationX;
  final double rotationY;
  final double underlineProgress;
  final double clipProgress;

  const CharacterAnimation({
    this.opacity = 1.0,
    this.translation = Offset.zero,
    this.scale = 1.0,
    this.scaleX = 1.0,
    this.scaleY = 1.0,
    this.color,
    this.backgroundColor,
    this.blurSigma = 0.0,
    this.rotation = 0.0,
    this.rotationX = 0.0,
    this.rotationY = 0.0,
    this.underlineProgress = 0.0,
    this.clipProgress = 1.0,
  });

  double get uniformScale => scale * scaleX;

  CharacterAnimation combine(CharacterAnimation other) {
    return CharacterAnimation(
      opacity: opacity * other.opacity,
      translation: translation + other.translation,
      scale: scale * other.scale,
      scaleX: scaleX * other.scaleX,
      scaleY: scaleY * other.scaleY,
      color: other.color ?? color,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      blurSigma: blurSigma + other.blurSigma,
      rotation: rotation + other.rotation,
      rotationX: rotationX + other.rotationX,
      rotationY: rotationY + other.rotationY,
      underlineProgress: underlineProgress + other.underlineProgress,
      clipProgress: clipProgress * other.clipProgress,
    );
  }
}
