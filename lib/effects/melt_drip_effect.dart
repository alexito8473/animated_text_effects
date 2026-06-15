import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters appear to melt and drip downward.
///
/// Each character compresses vertically ([meltAmount]), slides down
/// ([dripHeight]), and blurs as it melts, creating a wax-like effect.
class MeltDripEffect extends TextEffect {
  /// Vertical compression factor (0.0 = no melt, 1.0 = fully compressed).
  final double meltAmount;

  /// Downward drip displacement in logical pixels.
  final double dripHeight;

  /// Gaussian blur applied during the melt.
  final double blurSigma;

  /// Creates a melt/drip animation effect.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve (easeIn for accelerating melt).
  /// [meltAmount] — vertical compression factor (0–1).
  /// [dripHeight] — downward drip displacement in pixels.
  /// [blurSigma] — Gaussian blur during melting.
  /// [delayBetweenChars] — stagger delay between characters.
  const MeltDripEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeIn,
    this.meltAmount = 0.5,
    this.dripHeight = 40.0,
    this.blurSigma = 3.0,
    super.delayBetweenChars = const Duration(milliseconds: 30),
  });

  /// Generates per-character melt (scaleY shrink, translate down, blur).
  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final returnT = sin(curved * pi);

      return CharacterAnimation(
        scaleY: 1.0 - meltAmount * returnT,
        translation: Offset(0, dripHeight * returnT),
        blurSigma: blurSigma * returnT,
      );
    });
  }
}
