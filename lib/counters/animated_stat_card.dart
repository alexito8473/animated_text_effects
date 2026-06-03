import 'package:flutter/material.dart';
import '../core/animated_counter.dart';

class AnimatedStatCard extends StatelessWidget {
  final num value;
  final String label;
  final IconData? icon;
  final int decimals;
  final Duration duration;
  final Curve curve;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;
  final Color? activeColor;
  final bool scalePulse;
  final Color? cardColor;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final bool autoplay;
  final String Function(num)? format;

  const AnimatedStatCard({
    super.key,
    required this.value,
    required this.label,
    this.icon,
    this.decimals = 0,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeOut,
    this.valueStyle,
    this.labelStyle,
    this.activeColor,
    this.scalePulse = false,
    this.cardColor,
    this.elevation = 2,
    this.padding = const EdgeInsets.all(20),
    this.autoplay = true,
    this.format,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: cardColor ?? theme.colorScheme.surfaceContainerHighest,
      elevation: elevation,
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 32, color: activeColor ?? theme.colorScheme.primary),
              const SizedBox(height: 8),
            ],
            Flexible(
              child: AnimatedCounter(
                value: value,
                duration: duration,
                curve: curve,
                style: (valueStyle ?? theme.textTheme.headlineMedium)
                    ?.copyWith(fontWeight: FontWeight.bold),
                decimals: decimals,
                activeColor: activeColor,
                scalePulse: scalePulse,
                autoplay: autoplay,
                format: format,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: labelStyle ??
                  theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
