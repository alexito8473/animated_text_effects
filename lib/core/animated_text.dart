import 'package:flutter/material.dart';
import 'text_effect.dart';
import 'text_effect_controller.dart';
import 'character_animation.dart';
import 'text_renderer.dart';

/// Displays animated text with one or more composable [TextEffect]s.
///
/// Each character is individually rendered and animated by combining the
/// output of all registered effects via [CharacterAnimation.combine].
///
/// Supports external playback control via [TextEffectController] and
/// preserves animation state when scrolled off-screen via [keepAlive].
///
/// ```dart
/// AnimatedText(
///   'Hello World',
///   effects: [FadeEffect(), WaveEffect()],
///   style: TextStyle(fontSize: 32),
/// )
/// ```
class AnimatedText extends StatefulWidget {
  /// The text string to animate character by character.
  final String text;

  /// List of animation effects applied and composed together.
  final List<TextEffect> effects;

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

  /// Text direction for layout (affects alignment and box selection).
  final TextDirection textDirection;

  /// Optional strut style for consistent line height.
  final StrutStyle? strutStyle;

  /// Optional text height behavior override.
  final TextHeightBehavior? textHeightBehavior;

  /// How text width is computed relative to the parent.
  final TextWidthBasis textWidthBasis;

  /// When true (default), animation state survives scroll-off in a lazy list.
  final bool keepAlive;

  /// Creates an [AnimatedText] widget that animates the given [text].
  ///
  /// [text] — the string to animate (required, positional).
  /// [effects] — list of [TextEffect]s composed onto the text.
  /// [controller] — optional external [TextEffectController].
  /// [style] — text style (falls back to [DefaultTextStyle]).
  /// [textAlign] — horizontal text alignment.
  /// [autoplay] — whether playback starts on mount.
  /// [repeat] — whether the animation loops indefinitely.
  /// [reverse] — whether looping plays forward then backward.
  /// [textDirection] — layout direction (affects alignment).
  /// [strutStyle] — optional strut for consistent line height.
  /// [textHeightBehavior] — optional height behavior override.
  /// [textWidthBasis] — how text width is computed.
  /// [keepAlive] — preserves animation in scroll-off (lazy list).
  const AnimatedText(
    this.text, {
    super.key,
    this.effects = const [],
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
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => widget.keepAlive;
  late AnimationController _controller;

  Duration _calculateDuration() {
    final charCount = widget.text.length;
    if (widget.effects.isEmpty || charCount == 0) return Duration.zero;
    return widget.effects
        .map((e) => e.getTotalDuration(charCount))
        .reduce((a, b) => a > b ? a : b);
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
  void didUpdateWidget(AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller!.detach();
      }
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

    final effectsChanged = oldWidget.effects != widget.effects;
    final textChanged = oldWidget.text != widget.text;
    final repeatChanged = oldWidget.repeat != widget.repeat ||
        oldWidget.reverse != widget.reverse;

    if (effectsChanged || textChanged || repeatChanged) {
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
    final charCount = widget.text.length;
    final progress = _controller.value;

    if (widget.effects.isEmpty || charCount == 0) {
      return List.generate(
        charCount,
        (_) => const CharacterAnimation(),
      );
    }

    final result = List<CharacterAnimation>.generate(
      charCount,
      (_) => const CharacterAnimation(),
    );

    for (final effect in widget.effects) {
      final effectAnimations = effect.getAnimations(progress, charCount);
      for (int i = 0; i < charCount; i++) {
        result[i] = result[i].combine(effectAnimations[i]);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final effectiveStyle = widget.style ?? DefaultTextStyle.of(context).style;
    final animations = _computeAnimations();
    return AnimatedTextRender(
      text: widget.text,
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
