import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// A horizontal scan line sweeps down the text with a bright highlight.
///
/// Each character briefly brightens as the scan passes, leaving a
/// subtle glow trail. Creates a CRT monitor / radar sweep effect.
class ScanLinesEffect extends TextEffect {
  /// Color of the scan line highlight.
  final Color scanColor;

  /// Width of the scan band as a fraction of character count.
  final double scanWidth;

  /// Intensity of the trailing glow (0.0–1.0).
  final double glowIntensity;

  /// Creates a scan line sweep animation.
  ///
  /// [duration] — one full scan sweep duration.
  /// [curve] — easing curve for the scan.
  /// [scanColor] — color of the scanning highlight.
  /// [scanWidth] — width of the scan band as fraction of total.
  /// [glowIntensity] — brightness of the trailing glow (0–1).
  /// [delayBetweenChars] — stagger (zero for smooth sweep).
  const ScanLinesEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.scanColor = Colors.cyan,
    this.scanWidth = 0.15,
    this.glowIntensity = 0.15,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);
    final scanPos = curved * charCount;

    return List.generate(charCount, (index) {
      final dist = (index - scanPos).abs();
      final band = scanWidth * charCount;

      Color? color;
      if (curved >= 0.995) {
        color = null;
      } else if (dist < band) {
        final intensity = (1.0 - dist / band).clamp(0.0, 1.0);
        color = scanColor.withValues(alpha: (0.2 + intensity * 0.8).clamp(0.0, 1.0));
      } else {
        final trailIntensity = (glowIntensity * (1.0 - (dist - band).abs() / charCount)).clamp(0.0, glowIntensity);
        if (trailIntensity > 0.01) {
          color = scanColor.withValues(alpha: trailIntensity);
        }
      }

      return CharacterAnimation(color: color);
    });
  }
}
