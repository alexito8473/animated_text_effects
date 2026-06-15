import 'package:flutter/material.dart';
import 'text_effect.dart';
import 'text_effect_controller.dart';
import 'character_animation.dart';
import 'sequence_text.dart';
import 'text_renderer.dart';

/// Cycles through a list of [SequenceText] items with optional transitions
/// between them.
///
/// Each item is displayed for [displayDuration], after which a transition
/// lasting [transitionDuration] switches to the next text. The transition
/// reuses [TextEffect] classes — when [transitionEffect] is provided, it is
/// applied to both the outgoing and incoming text as a whole.
///
/// ```dart
/// AnimatedTextSequence(
///   texts: [
///     SequenceText('Hello', effects: [FadeEffect(), WaveEffect()]),
///     SequenceText('World', effects: [SlideEffect()]),
///   ],
///   transitionEffect: FadeEffect(),
/// )
/// ```
class AnimatedTextSequence extends StatefulWidget {
  /// Ordered list of [SequenceText] items to cycle through.
  final List<SequenceText> texts;

  /// Optional external controller for shared playback orchestration.
  final TextEffectController? controller;

  /// Base text style applied to all items (overridable per [SequenceText]).
  final TextStyle? style;

  /// Horizontal text alignment.
  final TextAlign textAlign;

  /// Whether playback begins automatically on mount.
  final bool autoplay;

  /// Whether the sequence loops back to the first item after the last.
  final bool repeat;

  /// Text direction for layout.
  final TextDirection textDirection;

  /// Optional strut style for consistent line height.
  final StrutStyle? strutStyle;

  /// Optional text height behavior override.
  final TextHeightBehavior? textHeightBehavior;

  /// How text width is computed relative to the parent.
  final TextWidthBasis textWidthBasis;

  /// When true, animation state survives scroll-off in a lazy list.
  final bool keepAlive;

  /// Duration each text is shown before transitioning to the next.
  final Duration displayDuration;

  /// Duration of the crossfade/transition between texts.
  final Duration transitionDuration;

  /// Optional [TextEffect] applied during the transition (both outgoing
  /// and incoming text).
  final TextEffect? transitionEffect;

  /// Creates an [AnimatedTextSequence] cycling through [texts].
  ///
  /// [texts] — ordered list of [SequenceText] items (required).
  /// [controller] — optional external [TextEffectController].
  /// [style] — base text style (overridable per item).
  /// [textAlign] — horizontal alignment.
  /// [autoplay] — whether playback starts on mount.
  /// [repeat] — whether the sequence loops (default true).
  /// [textDirection] — layout direction.
  /// [strutStyle] — optional strut for line height consistency.
  /// [textHeightBehavior] — optional height behavior override.
  /// [textWidthBasis] — how text width is computed.
  /// [keepAlive] — preserves state in scroll-off.
  /// [displayDuration] — how long each text is shown.
  /// [transitionDuration] — transition duration between texts.
  /// [transitionEffect] — optional effect during transitions.
  const AnimatedTextSequence({
    super.key,
    required this.texts,
    this.controller,
    this.style,
    this.textAlign = TextAlign.start,
    this.autoplay = true,
    this.repeat = true,
    this.textDirection = TextDirection.ltr,
    this.strutStyle,
    this.textHeightBehavior,
    this.textWidthBasis = TextWidthBasis.parent,
    this.keepAlive = true,
    this.displayDuration = const Duration(seconds: 3),
    this.transitionDuration = const Duration(milliseconds: 500),
    this.transitionEffect,
  });

  @override
  State<AnimatedTextSequence> createState() => _AnimatedTextSequenceState();
}

enum _SeqPhase { display, transition }

class _AnimatedTextSequenceState extends State<AnimatedTextSequence>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  /// Internal animation controller driving both display and transition phases.
  late AnimationController _controller;

  /// Index of the currently displayed [SequenceText] in [widget.texts].
  int _currentIndex = 0;

  /// Current phase of the sequence — either displaying or transitioning.
  _SeqPhase _phase = _SeqPhase.display;

  /// Whether [_controller] has been initialized (guards disposal).
  bool _started = false;

  bool get _hasMultiple => widget.texts.length > 1;

  String _effectiveText(int index) => widget.texts[index].text;
  int _nextIndex() => (_currentIndex + 1) % widget.texts.length;
  double get _progress => _controller.value;

  void _onTick() => setState(() {});

  void _onPhaseComplete() {
    if (!mounted) return;

    final nextDuration = _phase == _SeqPhase.display
        ? widget.transitionDuration
        : widget.displayDuration;
    if (nextDuration <= Duration.zero) return;

    if (_phase == _SeqPhase.display) {
      // Display just finished -> switch to transition phase
      if (!_hasMultiple) {
        // Single text: just restart display
        _controller
          ..duration = widget.displayDuration
          ..forward(from: 0);
        return;
      }
      _phase = _SeqPhase.transition;
      _controller
        ..duration = widget.transitionDuration
        ..forward(from: 0);
    } else {
      // Transition just finished -> advance to next text's display phase
      _currentIndex = _nextIndex();
      _phase = _SeqPhase.display;
      if (_currentIndex == 0 && !widget.repeat) return;
      _controller
        ..duration = widget.displayDuration
        ..forward(from: 0);
    }
  }

  void _setup() {
    _phase = _SeqPhase.display;
    _currentIndex = 0;

    if (widget.controller != null) {
      widget.controller!.attach(this, Duration.zero, _onTick);
      _controller = widget.controller!.animationController!;
      return;
    }

    _controller = AnimationController(
      vsync: this,
      duration: widget.displayDuration,
    )..addListener(_onTick);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _onPhaseComplete();
    });

    if (widget.autoplay && widget.displayDuration > Duration.zero) {
      _controller.forward(from: 0);
    }
    _started = true;
  }

  @override
  void initState() {
    super.initState();
    if (widget.texts.isNotEmpty) _setup();
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.detach();
    } else if (_started) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedTextSequence oldWidget) {
    super.didUpdateWidget(oldWidget);
    final changed = oldWidget.texts.length != widget.texts.length ||
        oldWidget.displayDuration != widget.displayDuration ||
        oldWidget.transitionDuration != widget.transitionDuration ||
        oldWidget.controller != widget.controller;
    if (changed) {
      if (oldWidget.controller != null) oldWidget.controller!.detach();
      if (_started) {
        _controller.removeListener(_onTick);
        _controller.dispose();
      }
      _setup();
    }
  }

  List<CharacterAnimation> _computeAnimations(int index, double progress) {
    final text = _effectiveText(index);
    final charCount = text.length;
    if (charCount == 0) return [];

    final seq = widget.texts[index];
    if (seq.effects.isEmpty) {
      return List.filled(charCount, const CharacterAnimation());
    }

    final result = List<CharacterAnimation>.filled(
        charCount, const CharacterAnimation());

    // Concatenate effects: each gets an equal segment of the display progress
    final effectCount = seq.effects.length;
    for (int e = 0; e < effectCount; e++) {
      final segStart = e / effectCount;
      final segEnd = (e + 1) / effectCount;
      final localProgress = progress < segStart
          ? 0.0
          : progress > segEnd
              ? 1.0
              : (progress - segStart) / (segEnd - segStart);

      final effectAnims =
          seq.effects[e].getAnimations(localProgress, charCount);
      for (int i = 0; i < charCount; i++) {
        result[i] = result[i].combine(effectAnims[i]);
      }
    }

    return result;
  }

  Widget _buildCurrentText(TextStyle effectiveStyle) {
    final text = _effectiveText(_currentIndex);
    if (text.isEmpty) return const SizedBox.shrink();

    final animations = _computeAnimations(_currentIndex, _progress);

    return AnimatedTextRender(
      text: text,
      animations: animations,
      textStyle: widget.texts[_currentIndex].style ?? effectiveStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      strutStyle: widget.strutStyle,
      textHeightBehavior: widget.textHeightBehavior,
      textWidthBasis: widget.textWidthBasis,
    );
  }

  Widget _buildSizingPlaceholder(int index, TextStyle effectiveStyle) {
    final text = _effectiveText(index);
    if (text.isEmpty) return const SizedBox.shrink();
    return Opacity(
      opacity: 0,
      child: AnimatedTextRender(
        text: text,
        animations: List.filled(text.length, const CharacterAnimation()),
        textStyle: widget.texts[index].style ?? effectiveStyle,
        textDirection: widget.textDirection,
        textAlign: widget.textAlign,
        strutStyle: widget.strutStyle,
        textHeightBehavior: widget.textHeightBehavior,
        textWidthBasis: widget.textWidthBasis,
      ),
    );
  }

  Widget _buildTransitionText(
    int index, {
    required bool isOutgoing,
    required TextStyle effectiveStyle,
  }) {
    final text = _effectiveText(index);
    if (text.isEmpty) return const SizedBox.shrink();

    final t = isOutgoing ? 1.0 - _progress : _progress;
    var animations = _computeAnimations(index, t);

    final eff = widget.transitionEffect;
    if (eff != null) {
      final effAnims = eff.getAnimations(t, 1);
      final charAnim =
          effAnims.isNotEmpty ? effAnims.first : const CharacterAnimation();
      animations = animations.map((a) => a.combine(charAnim)).toList();
    }

    return AnimatedTextRender(
      text: text,
      animations: animations,
      textStyle: widget.texts[index].style ?? effectiveStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      strutStyle: widget.strutStyle,
      textHeightBehavior: widget.textHeightBehavior,
      textWidthBasis: widget.textWidthBasis,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.texts.isEmpty) return const SizedBox.shrink();

    final effectiveStyle = widget.style ?? DefaultTextStyle.of(context).style;

    if (_phase == _SeqPhase.transition && _hasMultiple) {
      // Transition phase: incoming text (invisible placeholder for sizing)
      // + outgoing text animated from 1→0 combined with transitionEffect
      return Stack(
        children: [
          _buildSizingPlaceholder(_nextIndex(), effectiveStyle),
          _buildTransitionText(
            _currentIndex,
            isOutgoing: true,
            effectiveStyle: effectiveStyle,
          ),
        ],
      );
    }

    // Display phase: show current text full size.
    // Placeholder for next text (opacity 0) keeps the Stack sized
    // identically across phases, preventing layout jumps.
    return Stack(
      children: [
        _buildCurrentText(effectiveStyle),
        if (_hasMultiple)
          _buildSizingPlaceholder(_nextIndex(), effectiveStyle),
      ],
    );
  }
}
