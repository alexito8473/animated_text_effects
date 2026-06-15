import 'package:flutter/material.dart';
import '../core/animated_counter.dart';

/// Animated percentage counter with a `%` suffix.
///
/// Wraps [AnimatedCounter] with automatic percentage formatting.
///
/// ```dart
/// AnimatedPercentage(value: 75.5, decimals: 1)
/// ```
class AnimatedPercentage extends StatelessWidget {
  /// The target numeric value to animate toward.
  final num value;

  /// Number of decimal places to display.
  final int decimals;

  /// Duration of the animation.
  final Duration duration;

  /// Curve applied to the value interpolation.
  final Curve curve;

  /// Text style for the displayed value.
  final TextStyle? style;

  /// Whether the animation starts automatically.
  final bool autoplay;

  /// When true, animation state survives scroll-off.
  final bool keepAlive;

  /// Optional color interpolation target.
  final Color? activeColor;

  /// When true, triggers a scale pulse near completion.
  final bool scalePulse;

  /// Whether to display the `%` suffix.
  final bool showPercentSign;

  /// Creates an animated percentage display.
  ///
  /// [value] — target numeric value to animate toward (required).
  /// [decimals] — decimal places to display.
  /// [duration] — animation duration.
  /// [curve] — easing curve for value interpolation.
  /// [style] — text style for the displayed value.
  /// [autoplay] — whether animation starts automatically.
  /// [keepAlive] — preserves animation state in scroll-off.
  /// [activeColor] — optional color interpolation target.
  /// [scalePulse] — scale pulse near completion.
  /// [showPercentSign] — whether to display the % suffix.
  const AnimatedPercentage({
    super.key,
    required this.value,
    this.decimals = 1,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeOut,
    this.style,
    this.autoplay = true,
    this.keepAlive = true,
    this.activeColor,
    this.scalePulse = false,
    this.showPercentSign = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCounter(
      value: value,
      duration: duration,
      curve: curve,
      style: style,
      autoplay: autoplay,
      keepAlive: keepAlive,
      decimals: decimals,
      activeColor: activeColor,
      scalePulse: scalePulse,
      format: (v) {
        final s = v.toStringAsFixed(decimals);
        return showPercentSign ? '$s%' : s;
      },
    );
  }
}
