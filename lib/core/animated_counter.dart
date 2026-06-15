import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Animates a numeric value with smooth transitions between changes.
///
/// Supports integers and decimals, optional color lerp via [activeColor],
/// and a completion pulse animation via [scalePulse].
///
/// ```dart
/// AnimatedCounter(
///   value: 42,
///   duration: Duration(seconds: 2),
///   decimals: 1,
/// )
/// ```
class AnimatedCounter extends StatefulWidget {
  /// The target numeric value to animate toward.
  final num value;

  /// Duration of the animation from current to target value.
  final Duration duration;

  /// Curve applied to the value interpolation.
  final Curve curve;

  /// Text style for the displayed number.
  final TextStyle? style;

  /// Optional custom formatter for the displayed string.
  final String Function(num)? format;

  /// Whether the animation starts automatically on mount or value change.
  final bool autoplay;

  /// When true (default), animation state survives scroll-off in a lazy list.
  final bool keepAlive;

  /// Number of decimal places to display (0 for integer formatting).
  final int decimals;

  /// When set, the text color interpolates from the style color to this
  /// color over the animation duration.
  final Color? activeColor;

  /// When true, triggers a short scale pulse near animation completion.
  final bool scalePulse;

  /// Creates an [AnimatedCounter] for the given [value].
  ///
  /// [value] — target numeric value to animate toward (required).
  /// [duration] — animation duration from current to target value.
  /// [curve] — easing curve for value interpolation.
  /// [style] — text style for the displayed number.
  /// [format] — optional custom formatter for the displayed string.
  /// [autoplay] — whether animation starts on mount or value change.
  /// [keepAlive] — preserves animation state in scroll-off.
  /// [decimals] — decimal places (0 = integer display).
  /// [activeColor] — optional color lerp target from style color.
  /// [scalePulse] — short scale pulse near animation completion.
  const AnimatedCounter({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeOut,
    this.style,
    this.format,
    this.autoplay = true,
    this.keepAlive = true,
    this.decimals = 0,
    this.activeColor,
    this.scalePulse = false,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;
  late AnimationController _controller;
  late Animation<double> _animation;
  num _displayValue = 0;
  num _startValue = 0;

  @override
  void initState() {
    super.initState();
    if (!widget.autoplay) {
      _displayValue = widget.value;
      _startValue = widget.value;
    }
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    _animation.addListener(_onAnimation);
    if (widget.autoplay) {
      _controller.forward();
    }
  }

  void _onAnimation() {
    setState(() {
      final t = _animation.value;
      final current = _startValue.toDouble();
      final target = widget.value.toDouble();
      _displayValue = current + (target - current) * t;
    });
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _startValue = _displayValue;
      _controller.reset();
      _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
      _animation.addListener(_onAnimation);
      _controller.forward();
    } else if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _resolveColor() {
    // If activeColor is set, lerp from base style color to activeColor
    // based on current animation progress. Otherwise use style color.
    if (widget.activeColor == null) {
      return widget.style?.color ?? Colors.white;
    }
    final base = widget.style?.color ?? Colors.white;
    return Color.lerp(base, widget.activeColor!, _controller.value)!;
  }

  double _resolveScale() {
    // Only apply scale pulse in the last 15% of the animation.
    // Uses a sine wave for a smooth scale-up-then-down bounce.
    if (!widget.scalePulse) return 1.0;
    final v = _controller.value;
    if (v < 0.85) return 1.0;
    final t = (v - 0.85) / 0.15;
    return 1.0 + math.sin(t * math.pi) * 0.08;
  }

  String _format() {
    // Use custom formatter if provided, otherwise format with decimals.
    if (widget.format != null) return widget.format!(_displayValue);
    if (widget.decimals > 0) {
      return _displayValue.toStringAsFixed(widget.decimals);
    }
    // Round to integer when decimals == 0
    return (_displayValue.round()).toString();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final color = _resolveColor();
    final scale = _resolveScale();
    final text = _format();

    Widget result = Text(
      text,
      style: (widget.style ?? const TextStyle()).copyWith(color: color),
    );

    if (scale != 1.0) {
      result = Transform.scale(scale: scale, child: result);
    }

    return result;
  }
}
