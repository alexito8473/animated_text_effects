import 'package:flutter/material.dart';
import '../core/animated_counter.dart';

/// Material Card with an animated value, optional icon, and label.
///
/// Combines [AnimatedCounter] with a styled [Card] layout for dashboard
/// and statistics displays.
///
/// ```dart
/// AnimatedStatCard(
///   value: 1337,
///   label: 'Active Users',
///   icon: Icons.people,
///   decimals: 0,
/// )
/// ```
class AnimatedStatCard extends StatelessWidget {
  /// The target numeric value to animate toward.
  final num value;

  /// Label text displayed below the value.
  final String label;

  /// Optional icon displayed above the value.
  final IconData? icon;

  /// Number of decimal places to display.
  final int decimals;

  /// Duration of the animation.
  final Duration duration;

  /// Curve applied to the value interpolation.
  final Curve curve;

  /// Text style for the animated value.
  final TextStyle? valueStyle;

  /// Text style for the label.
  final TextStyle? labelStyle;

  /// Optional color interpolation target for the value.
  final Color? activeColor;

  /// When true, triggers a scale pulse near completion.
  final bool scalePulse;

  /// Background color of the card.
  final Color? cardColor;

  /// Card elevation for shadow depth.
  final double elevation;

  /// Padding around the card content.
  final EdgeInsetsGeometry padding;

  /// Whether the animation starts automatically.
  final bool autoplay;

  /// Optional custom formatter for the displayed number.
  final String Function(num)? format;

  /// Creates an animated statistics card.
  ///
  /// [value] — target numeric value to animate toward (required).
  /// [label] — label text below the value (required).
  /// [icon] — optional icon above the value.
  /// [decimals] — decimal places to display.
  /// [duration] — animation duration.
  /// [curve] — easing curve for value interpolation.
  /// [valueStyle] — text style for the animated value.
  /// [labelStyle] — text style for the label.
  /// [activeColor] — optional color interpolation target.
  /// [scalePulse] — scale pulse near completion.
  /// [cardColor] — background color of the card.
  /// [elevation] — card shadow depth.
  /// [padding] — padding around card content.
  /// [autoplay] — whether animation starts automatically.
  /// [format] — optional custom formatter for the number.
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
