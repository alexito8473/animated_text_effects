import 'package:flutter/material.dart';
import '../core/animated_counter.dart';

class AnimatedCurrency extends StatelessWidget {
  final num value;
  final int decimals;
  final String symbol;
  final Duration duration;
  final Curve curve;
  final TextStyle? style;
  final bool autoplay;
  final bool keepAlive;
  final Color? activeColor;
  final bool scalePulse;
  final bool showPlusSign;

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
