import 'package:flutter/material.dart';
import 'text_effect.dart';
import 'text_effect_controller.dart';
import 'character_animation.dart';
import 'text_segment.dart';
import 'text_renderer.dart';

/// Displays text with mixed static and animated segments.
///
/// Each [TextSegment] can be either static (no animation) or animated
/// with its own list of [TextEffect]s. All segments are concatenated
/// into a single string, but effects only apply to animated segments.
///
/// ```dart
/// AnimatedRichText(
///   segments: [
///     TextSegment.static('Hello '),
///     TextSegment.animated('World', effects: [WaveEffect()]),
///     TextSegment.static('!'),
///   ],
///   style: TextStyle(fontSize: 32),
/// )
/// ```
class AnimatedRichText extends StatefulWidget {
  /// The text segments composing the full text.
  final List<TextSegment> segments;

  /// Optional external controller for shared playback orchestration.
  final TextEffectController? controller;

  /// Text style applied to every character. Defaults to [DefaultTextStyle].
  final TextStyle? style;

  /// Alignment of the text within its bounds.
  final TextAlign textAlign;

  /// Whether playback begins automatically on mount.
  final bool autoplay;

  /// Whether the animation loops indefinitely.
  final bool repeat;

  /// Whether repeated animations play forwards then backwards.
  final bool reverse;

  /// Text direction for layout.
  final TextDirection textDirection;

  /// Optional strut style for consistent line height.
  final StrutStyle? strutStyle;

  /// Optional text height behavior override.
  final TextHeightBehavior? textHeightBehavior;

  /// How text width is computed relative to the parent.
  final TextWidthBasis textWidthBasis;

  /// When true (default), animation state survives scroll-off in a lazy list.
  final bool keepAlive;

  /// Creates an [AnimatedRichText] from mixed static/animated segments.
  ///
  /// [segments] — ordered list of [TextSegment]s (required).
  /// [controller] — optional external [TextEffectController].
  /// [style] — base text style (falls back to [DefaultTextStyle]).
  /// [textAlign] — horizontal text alignment.
  /// [autoplay] — whether playback starts on mount.
  /// [repeat] — whether the animation loops indefinitely.
  /// [reverse] — whether looping plays forward then backward.
  /// [textDirection] — layout direction.
  /// [strutStyle] — optional strut for line height consistency.
  /// [textHeightBehavior] — optional height behavior override.
  /// [textWidthBasis] — how text width is computed.
  /// [keepAlive] — preserves animation in scroll-off.
  const AnimatedRichText({
    super.key,
    required this.segments,
    this.controller,
    this.style,
    this.textAlign = TextAlign.start,
    this.autoplay = true,
    this.repeat = false,
    this.reverse = false,
    this.textDirection = TextDirection.ltr,
    this.strutStyle,
    this.textHeightBehavior,
    this.textWidthBasis = TextWidthBasis.parent,
    this.keepAlive = true,
  });

  @override
  State<AnimatedRichText> createState() => _AnimatedRichTextState();
}

/// Maps a [TextSegment] to its range within the concatenated full text.
class _SegmentMapping {
  /// The original segment from [AnimatedRichText.segments].
  final TextSegment segment;

  /// Global index of the first character of this segment in the full text.
  final int startIndex;

  /// Global index one past the last character of this segment.
  final int endIndex;

  _SegmentMapping(this.segment, this.startIndex, this.endIndex);
}

class _AnimatedRichTextState extends State<AnimatedRichText>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;
  late AnimationController _controller;

  String _getFullText() {
    return widget.segments.map((s) => s.text).join();
  }

  List<_SegmentMapping> _buildMappings() {
    final mappings = <_SegmentMapping>[];
    int offset = 0;
    for (final segment in widget.segments) {
      final end = offset + segment.text.length;
      mappings.add(_SegmentMapping(segment, offset, end));
      offset = end;
    }
    return mappings;
  }

  Duration _calculateDuration() {
    final charCount = _getFullText().length;
    if (charCount == 0) return Duration.zero;

    Duration maxDuration = Duration.zero;
    for (final segment in widget.segments) {
      if (!segment.isAnimated) continue;
      for (final effect in segment.effects) {
        final segCharCount = segment.text.length;
        final d = effect.getTotalDuration(segCharCount);
        if (d > maxDuration) maxDuration = d;
      }
    }
    return maxDuration;
  }

  void _onTick() => setState(() {});

  void _initController(Duration duration) {
    if (widget.controller != null) {
      widget.controller!.attach(this, duration, _onTick);
      _controller = widget.controller!.animationController!;
    } else {
      _controller = AnimationController(vsync: this, duration: duration);
      if (duration > Duration.zero) {
        if (widget.autoplay && widget.repeat) {
          _controller.repeat(reverse: widget.reverse);
        } else if (widget.autoplay) {
          _controller.forward();
        }
      }
      _controller.addListener(_onTick);
    }
  }

  @override
  void initState() {
    super.initState();
    _initController(_calculateDuration());
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.detach();
    } else {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedRichText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller != null) oldWidget.controller!.detach();
      if (widget.controller != null) {
        widget.controller!.attach(this, _calculateDuration(), _onTick);
        _controller = widget.controller!.animationController!;
      } else {
        _controller = AnimationController(vsync: this, duration: _calculateDuration());
        if (widget.autoplay && widget.repeat) {
          _controller.repeat(reverse: widget.reverse);
        } else if (widget.autoplay) {
          _controller.forward();
        }
        _controller.addListener(_onTick);
      }
      return;
    }

    final segmentsChanged = oldWidget.segments != widget.segments;
    final repeatChanged =
        oldWidget.repeat != widget.repeat || oldWidget.reverse != widget.reverse;

    if (segmentsChanged || repeatChanged) {
      _controller.duration = _calculateDuration();
      if (_controller.duration != null && _controller.duration! > Duration.zero) {
        _controller.reset();
        if (widget.repeat) {
          _controller.repeat(reverse: widget.reverse);
        } else if (widget.autoplay) {
          _controller.forward();
        }
      }
    } else {
      final newDuration = _calculateDuration();
      if (newDuration != _controller.duration) {
        _controller.duration = newDuration;
      }
    }
  }

  List<CharacterAnimation> _computeAnimations() {
    final fullText = _getFullText();
    final charCount = fullText.length;
    final progress = _controller.value;

    if (charCount == 0) return [];

    final result = List<CharacterAnimation>.generate(
      charCount,
      (_) => const CharacterAnimation(),
    );

    // Build mappings: each segment knows its start/end in the concatenated string
    final mappings = _buildMappings();

    for (final mapping in mappings) {
      if (!mapping.segment.isAnimated) continue;
      if (mapping.segment.effects.isEmpty) continue;

      final segText = mapping.segment.text;
      final segCharCount = segText.length;
      if (segCharCount == 0) continue;

      // For each effect, get per-character animations for the segment only,
      // then write them to the global animation array at the correct offset.
      for (final effect in mapping.segment.effects) {
        final effectAnimations = effect.getAnimations(progress, segCharCount);
        for (int i = 0; i < segCharCount; i++) {
          final globalIndex = mapping.startIndex + i;
          result[globalIndex] = result[globalIndex].combine(effectAnimations[i]);
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final effectiveStyle = widget.style ?? DefaultTextStyle.of(context).style;
    final fullText = _getFullText();
    final animations = _computeAnimations();

    if (fullText.isEmpty) return const SizedBox.shrink();

    return AnimatedTextRender(
      text: fullText,
      animations: animations,
      textStyle: effectiveStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      strutStyle: widget.strutStyle,
      textHeightBehavior: widget.textHeightBehavior,
      textWidthBasis: widget.textWidthBasis,
    );
  }
}
