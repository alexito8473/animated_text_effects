import 'package:flutter/material.dart';
import '../core/animated_counter.dart';

/// Animated currency counter with configurable symbol and formatting.
///
/// Wraps [AnimatedCounter] with thousands-separator, currency symbol,
/// and optional plus sign formatting.
///
/// ```dart
/// AnimatedCurrency(value: 1234.56, symbol: r'$', showPlusSign: true)
/// ```
class AnimatedCurrency extends StatelessWidget {
  /// The target numeric value to animate toward.
  final num value;

  /// Number of decimal places to display.
  final int decimals;

  /// Currency symbol prefix (e.g. `\$`, `€`, `£`).
  final String symbol;

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

  /// When true, shows a `+` prefix for non-negative values.
  final bool showPlusSign;

  /// Creates an animated currency display.
  ///
  /// [value] — target numeric value to animate toward (required).
  /// [decimals] — decimal places to display (default 2 for currency).
  /// [symbol] — currency symbol prefix (e.g. $, €, £).
  /// [duration] — animation duration.
  /// [curve] — easing curve for value interpolation.
  /// [style] — text style for the displayed value.
  /// [autoplay] — whether animation starts automatically.
  /// [keepAlive] — preserves animation state in scroll-off.
  /// [activeColor] — optional color interpolation target.
  /// [scalePulse] — scale pulse near completion.
  /// [showPlusSign] — shows + prefix for non-negative values.
  const AnimatedCurrency({
    super.key,
    required this.value,
    this.decimals = 2,
    this.symbol = r'$',
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeOut,
    this.style,
    this.autoplay = true,
    this.keepAlive = true,
    this.activeColor,
    this.scalePulse = false,
    this.showPlusSign = false,
  });

  String _format(num v) {
    final sign = showPlusSign && v >= 0 ? '+' : '';
    final s = v.toStringAsFixed(decimals);
    final parts = s.split('.');
    final intPart = parts[0];
    final buf = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      if (i > 0 && (intPart.length - i) % 3 == 0) buf.write(',');
      buf.write(intPart[i]);
    }
    final formatted = parts.length > 1 ? '$buf.${parts[1]}' : buf.toString();
    return '$sign$symbol$formatted';
  }

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
      format: _format,
    );
  }
}
