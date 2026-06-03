import 'dart:math';
import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

class MeltDripEffect extends TextEffect {
  final double meltAmount;
  final double dripHeight;
  final double blurSigma;

  const MeltDripEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeIn,
    this.meltAmount = 0.5,
    this.dripHeight = 40.0,
    this.blurSigma = 3.0,
    super.delayBetweenChars = const Duration(milliseconds: 30),
  });

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
