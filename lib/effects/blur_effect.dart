import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Transitions characters from blurry to sharp (or vice versa).
///
/// Each character starts with a Gaussian blur of [sigmaFrom] and resolves
/// to [sigmaTo], creating a focus-in effect.
class BlurEffect extends TextEffect {
  /// Starting blur sigma (higher = blurrier).
  final double sigmaFrom;

  /// Ending blur sigma (0.0 = perfectly sharp).
  final double sigmaTo;

  /// Creates a blur transition animation.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the blur transition.
  /// [delayBetweenChars] — stagger delay between characters.
  /// [sigmaFrom] — initial blur sigma (higher = blurrier).
  /// [sigmaTo] — final blur sigma (0 = sharp).
  const BlurEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = const Duration(milliseconds: 40),
    this.sigmaFrom = 8.0,
    this.sigmaTo = 0.0,
  });

  /// Generates per-character blur animations, transitioning from
  /// [sigmaFrom] to [sigmaTo] based on staggered progress.
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final sigma = sigmaFrom + (sigmaTo - sigmaFrom) * curved;
      return CharacterAnimation(blurSigma: sigma.clamp(0.0, double.infinity));
    });
  }
}
