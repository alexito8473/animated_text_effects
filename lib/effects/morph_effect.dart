import 'package:flutter/material.dart';
import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Characters cycle through intermediate glyphs before settling.
///
/// Each character rapidly transitions through a sequence of morph stages
/// (shape transitions) before resolving to the final character, creating
/// a fluid morphing effect distinct from the random ScrambleEffect.
class MorphEffect extends TextEffect {
  /// Seed for the deterministic morph sequence.
  final int seed;

  /// Characters used as morph intermediates.
  final String charset;

  /// Creates a smooth morph transition effect.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the morph.
  /// [delayBetweenChars] — stagger delay between characters.
  /// [seed] — deterministic seed for morph order.
  /// [charset] — characters used for morph intermediates.
  const MorphEffect({
    super.duration = const Duration(milliseconds: 1500),
    super.curve = Curves.easeInOut,
    super.delayBetweenChars = const Duration(milliseconds: 25),
    this.seed = 42,
    this.charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);

      final stageCount = 4;
      final rawStage = curved * stageCount;
      final stage = rawStage.floor().clamp(0, stageCount - 1);

      final morphIdx = (noise(index, seed + stage) * charset.length).floor();
      final morphChar = charset[morphIdx % charset.length];

      return CharacterAnimation(
        character: curved < 1.0 ? morphChar : null,
        opacity: curved.clamp(0.0, 1.0),
        scale: 0.7 + 0.3 * curved,
        blurSigma: (1.0 - curved) * 2.0,
      );
    });
  }
}
