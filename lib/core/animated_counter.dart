import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedCounter extends StatefulWidget {
  final num value;
  final Duration duration;
  final Curve curve;
  final TextStyle? style;
  final String Function(num)? format;
  final bool autoplay;
  final bool keepAlive;
  final int decimals;
  final Color? activeColor;
  final bool scalePulse;

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
    if (widget.activeColor == null) {
      return widget.style?.color ?? Colors.white;
    }
    final base = widget.style?.color ?? Colors.white;
    return Color.lerp(base, widget.activeColor!, _controller.value)!;
  }

  double _resolveScale() {
    if (!widget.scalePulse) return 1.0;
    final v = _controller.value;
    if (v < 0.85) return 1.0;
    final t = (v - 0.85) / 0.15;
    return 1.0 + math.sin(t * math.pi) * 0.08;
  }

  String _format() {
    if (widget.format != null) return widget.format!(_displayValue);
    if (widget.decimals > 0) {
      return _displayValue.toStringAsFixed(widget.decimals);
    }
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
