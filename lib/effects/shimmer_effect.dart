import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Sweeps a bright highlight band across the text.
///
/// Characters transition from [baseColor] to [highlightColor] as the band
/// passes, creating a metallic shimmer or loading effect.
class ShimmerEffect extends TextEffect {
  /// Default color of characters outside the highlight band.
  final Color baseColor;

  /// Bright color of the sweeping highlight.
  final Color highlightColor;

  /// Width of the highlight band as a fraction of the text (0.0–1.0).
  final double width;

  /// Creates a shimmer highlight sweep animation.
  ///
  /// [duration] — one full shimmer sweep duration.
  /// [curve] — easing curve for the sweep.
  /// [baseColor] — default color outside the highlight band.
  /// [highlightColor] — bright highlight band color.
  /// [width] — highlight band width as fraction (0–1).
  /// [delayBetweenChars] — stagger (zero for smooth sweep).
  const ShimmerEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.white,
    this.width = 0.3,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character color lerp from highlight band position.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      final charPos = index / (charCount - 1).clamp(1, charCount);
      final returnT = sin(curved * pi);
      final highlightCenter = returnT;
      final dist = (charPos - highlightCenter).abs();
      final intensity = (1 - (dist / width)).clamp(0.0, 1.0);
      final color = Color.lerp(baseColor, highlightColor, intensity)!;
      return CharacterAnimation(color: color);
    });
  }
}
