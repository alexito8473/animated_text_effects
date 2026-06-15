import 'package:flutter/material.dart';
import 'text_effect.dart';
import 'text_segment.dart';

/// A single entry in an [AnimatedTextSequence].
///
/// Each [SequenceText] carries its own text, optional effects,
/// optional style override, and optional inline segments for
/// mixed animated/static content.
class SequenceText {
  /// The text to display.
  final String text;

  /// Animation effects applied to this text.
  final List<TextEffect> effects;

  /// Optional style override for this item.
  final TextStyle? style;

  /// Optional inline segments for mixed content (static + animated).
  ///
  /// When set, [effects] are ignored for this item in favor of
  /// per-segment effects. The segments' text content must exactly
  /// concatenate to [text] or be ignored.
  final List<TextSegment>? segments;

  /// Creates a [SequenceText] entry for [AnimatedTextSequence].
  ///
  /// [text] — the text to display (required, positional).
  /// [effects] — animation effects applied to the text.
  /// [style] — optional style override for this item.
  /// [segments] — optional mixed static/animated segments.
  ///   When set, takes priority over [effects].
  const SequenceText(
    this.text, {
    this.effects = const [],
    this.style,
    this.segments,
  });
}
