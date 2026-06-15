import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Applies a pulsing glow effect behind the text.
///
/// The glow oscillates between [blurMin]/[blurMax] and
/// [opacityMin]/[opacityMax], with an optional [glowColor] tint.
class GlowEffect extends TextEffect {
  /// Minimum blur sigma at the glow's weakest point.
  final double blurMin;

  /// Maximum blur sigma at the glow's strongest point.
  final double blurMax;

  /// Minimum opacity at the glow's weakest point.
  final double opacityMin;

  /// Maximum opacity at the glow's strongest point.
  final double opacityMax;

  /// Optional color tint applied while glowing.
  final Color? glowColor;

  /// Creates a pulsing glow animation.
  ///
  /// [duration] — one full glow pulse duration.
  /// [curve] — easing curve for the pulse.
  /// [blurMin] — minimum blur sigma at trough.
  /// [blurMax] — maximum blur sigma at peak.
  /// [opacityMin] — minimum opacity at trough.
  /// [opacityMax] — maximum opacity at peak.
  /// [glowColor] — optional color tint while glowing.
  /// [delayBetweenChars] — stagger (zero for simultaneous glow).
  const GlowEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.blurMin = 3.0,
    this.blurMax = 12.0,
    this.opacityMin = 0.6,
    this.opacityMax = 1.0,
    this.glowColor,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates uniform blur/opacity/color pulse across all characters.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final breath = sin(curved * pi);

    final blur = blurMin + (blurMax - blurMin) * breath;
    final opacity = opacityMin + (opacityMax - opacityMin) * breath;

    return List.generate(charCount, (_) {
      return CharacterAnimation(
        blurSigma: blur,
        opacity: opacity,
        color: glowColor,
      );
    });
  }
}
