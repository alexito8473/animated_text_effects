import '../core/text_effect.dart';
import '../core/character_animation.dart';

class FadeEffect extends TextEffect {
  final double opacityFrom;
  final double opacityTo;

  const FadeEffect({
    super.duration,
    super.curve,
    super.delayBetweenChars = const Duration(milliseconds: 50),
    this.opacityFrom = 0.0,
    this.opacityTo = 1.0,
  });

  @override
  List<CharacterAnimation> getAnimations(double progress, int charCount) {
    if (charCount == 0) return [];

    return List.generate(charCount, (index) {
      final staggered = staggeredProgress(progress, index, charCount);
      final curved = applyCurve(staggered);
      final opacity = opacityFrom + (opacityTo - opacityFrom) * curved;
      return CharacterAnimation(opacity: opacity.clamp(0.0, 1.0));
    });
  }
}
