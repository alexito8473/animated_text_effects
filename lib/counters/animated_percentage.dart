import 'package:flutter/material.dart';
import '../core/animated_counter.dart';

class AnimatedPercentage extends StatelessWidget {
  final num value;
  final int decimals;
  final Duration duration;
  final Curve curve;
  final TextStyle? style;
  final bool autoplay;
  final bool keepAlive;
  final Color? activeColor;
  final bool scalePulse;
  final bool showPercentSign;

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
