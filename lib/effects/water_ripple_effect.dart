import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Ripples characters like water disturbed by a droplet.
///
/// A wave radiates from the center of the text, displacing characters
/// vertically and horizontally with decreasing intensity, creating a
/// water ripple / pond effect.
class WaterRippleEffect extends TextEffect {
  /// Maximum vertical displacement amplitude in logical pixels.
  final double amplitude;

  /// Number of ripple rings radiating from center.
  final int rippleCount;

  /// Damping factor (0.0–1.0) for how fast the ripple decays.
  final double damping;

  /// Creates a water ripple animation.
  ///
  /// [duration] — one full ripple propagation duration.
  /// [curve] — easing curve for the wave.
  /// [amplitude] — max vertical displacement in pixels.
  /// [rippleCount] — number of ripple rings.
  /// [damping] — decay rate of the ripple (0 = instant, 1 = no decay).
  /// [delayBetweenChars] — stagger (zero for propagation-based timing).
  const WaterRippleEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    this.amplitude = 12.0,
    this.rippleCount = 3,
    this.damping = 0.6,
    super.delayBetweenChars = Duration.zero,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount <= 1) return List.filled(charCount, const CharacterAnimation());

    final curved = applyCurve(progress);
    final returnT = sin(curved * pi);

    return List.generate(charCount, (index) {
      final center = (charCount - 1) / 2.0;
      final dist = (index - center).abs() / center;
      final waveStart = dist * (1.0 - damping);

      final localProgress = ((curved - waveStart) / (1.0 - waveStart + 0.01)).clamp(0.0, 1.0);
      final wave = sin(localProgress * pi * rippleCount);
      final decay = (1.0 - dist * damping).clamp(0.0, 1.0);
      final displacement = wave * amplitude * decay * returnT;

      final dx = wave.sign * amplitude * 0.3 * decay * returnT;

      return CharacterAnimation(
        translation: Offset(dx, displacement),
        scaleX: 1.0 + wave * 0.05 * decay * returnT,
      );
    });
  }
}
