import '../core/text_effect.dart';
import '../core/character_animation.dart';

/// Fades characters in sequentially from [opacityFrom] to [opacityTo].
///
/// Each character starts transparent and becomes opaque with a staggered
/// delay, creating a wave-like reveal effect.
class FadeEffect extends TextEffect {
  /// Starting opacity (0.0 = fully transparent).
  final double opacityFrom;

  /// Ending opacity (1.0 = fully opaque).
  final double opacityTo;

  /// Creates a fade animation with configurable opacity range.
  ///
  /// [duration] — animation cycle duration per character.
  /// [curve] — easing curve for the fade.
  /// [delayBetweenChars] — stagger delay between characters.
  /// [opacityFrom] — starting opacity (0 = transparent).
  /// [opacityTo] — ending opacity (1 = opaque).
  const FadeEffect({
    super.duration,
    super.curve,
    super.delayBetweenChars = const Duration(milliseconds: 50),
    this.opacityFrom = 0.0,
    this.opacityTo = 1.0,
  });

  /// Generates per-character opacity transitions from [opacityFrom] to [opacityTo].
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
