import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Simulates a flickering neon sign with random glow and blur.
///
/// Uses multi-frequency noise to create irregular flicker patterns,
/// alternating between [baseColor] and [glowColor] with blur.
class NeonFlickerEffect extends TextEffect {
  /// Base (dim) color of the neon text.
  final Color baseColor;

  /// Bright glow color during flicker peaks.
  final Color glowColor;

  /// Gaussian blur sigma applied when glowing.
  final double blurSigma;

  /// Seed for the deterministic flicker pattern.
  final int flickerSeed;

  /// Creates a neon flicker animation with random timing.
  ///
  /// [duration] — one full flicker pattern duration.
  /// [curve] — easing (linear for instant flicker transitions).
  /// [baseColor] — dim/base color when not glowing brightly.
  /// [glowColor] — bright glow color during flicker peaks.
  /// [blurSigma] — Gaussian blur applied when glowing.
  /// [flickerSeed] — seed for deterministic flicker pattern.
  /// [delayBetweenChars] — stagger (zero for varied per-char flicker).
  const NeonFlickerEffect({
    super.duration = const Duration(milliseconds: 2000),
    super.curve = Curves.linear,
    this.baseColor = Colors.cyan,
    this.glowColor = Colors.cyan,
    this.blurSigma = 6.0,
    this.flickerSeed = 42,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character flicker using multi-frequency noise.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final curved = applyCurve(progress);
      final returnT = sin(curved * pi);
      final flickerT = progress * duration.inMicroseconds / 1000000.0;
      final seed = flickerSeed + index;

      final flicker = noise(seed, (flickerT * 10).floor()) > 0.6 ? 1.0 : 0.3;
      final flickerSlow = noise(seed, (flickerT * 3).floor()) > 0.5 ? 1.0 : 0.5;
      final targetOpacity = flicker * flickerSlow;
      final opacity = 1.0 + (targetOpacity - 1.0) * returnT;

      final useFlicker = returnT > 0.001;
      return CharacterAnimation(
        opacity: opacity.clamp(0.0, 1.0),
        blurSigma: useFlicker && targetOpacity > 0.5 ? blurSigma : 0.0,
        color: useFlicker
            ? (targetOpacity > 0.5 ? glowColor : baseColor)
            : null,
      );
    });
  }
}
