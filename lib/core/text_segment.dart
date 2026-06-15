import 'text_effect.dart';

/// A segment of text that can be either static or animated.
///
/// Used by [AnimatedRichText] to mix animated and non-animated parts
/// within a single text string.
class TextSegment {
  /// The text content of this segment.
  final String text;

  /// Whether this segment is animated.
  final bool isAnimated;

  /// Effects applied only when [isAnimated] is true.
  final List<TextEffect> effects;

  /// Creates a static (non-animated) text segment.
  ///
  /// [text] — the literal text to display without any animation effects.
  const TextSegment.static(this.text)
      : isAnimated = false,
        effects = const [];

  /// Creates an animated text segment with the given [effects].
  ///
  /// [text] — the text to animate.
  /// [effects] — list of [TextEffect]s applied to this segment.
  const TextSegment.animated(this.text, {this.effects = const []})
      : isAnimated = true;
}
