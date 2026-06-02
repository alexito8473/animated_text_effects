import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class BlurEffect extends TextEffect {
  final double sigmaFrom;
  final double sigmaTo;

  const BlurEffect({
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.easeOut,
    super.delayBetweenChars = const Duration(milliseconds: 40),
    this.sigmaFrom = 8.0,
    this.sigmaTo = 0.0,
  });

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
