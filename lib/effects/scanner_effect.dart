import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// A scanning line sweeps across the text revealing characters.
///
/// Characters are revealed via clip as the scan passes, with a bright
/// color highlight and trailing glow effect.
class ScannerEffect extends TextEffect {
  /// Color of the scanning highlight line.
  final Color scanColor;

  /// Width of the bright scan line as a fraction of text width.
  final double scanWidth;

  /// Width of the trailing glow as a fraction of text width.
  final double glowWidth;

  /// Creates a scanner-style reveal animation.
  ///
  /// [duration] — one full scan cycle duration.
  /// [curve] — easing curve for the scan.
  /// [scanColor] — color of the bright scan highlight.
  /// [scanWidth] — bright scan band width as fraction of text.
  /// [glowWidth] — trailing glow width as fraction of text.
  /// [delayBetweenChars] — stagger (zero for smooth scan sweep).
  const ScannerEffect({
    super.duration = const Duration(milliseconds: 1200),
    super.curve = Curves.easeInOut,
    this.scanColor = Colors.cyan,
    this.scanWidth = 0.15,
    this.glowWidth = 0.3,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  Duration getTotalDuration(int charCount) {
    return duration;
  }

  /// Generates per-character clip reveal and color highlight from scan head.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    final curved = applyCurve(progress);

    return List.generate(charCount, (index) {
      final scanPos = curved * charCount;
      final lastRevealed = scanPos - 1;
      final maxDist = (charCount - 1).clamp(1, charCount);
      final dist = lastRevealed >= 0
          ? (index - lastRevealed).abs() / maxDist
          : double.infinity;

      Color? color;
      if (dist < glowWidth) {
        final intensity = (1.0 - dist / glowWidth).clamp(0.0, 1.0);
        if (dist < scanWidth) {
          color = scanColor.withValues(alpha: 0.8 + intensity * 0.2);
        } else {
          color = scanColor.withValues(alpha: intensity * 0.3);
        }
      }

      return CharacterAnimation(
        clipProgress: index < scanPos.ceil() ? 1.0 : 0.0,
        color: color,
      );
    });
  }
}
