import 'package:flutter/material.dart';

class RollingDigitCounter extends StatefulWidget {
  final num value;
  final int decimals;
  final Duration duration;
  final TextStyle? style;
  final bool autoplay;
  final bool keepAlive;
  final double digitWidth;
  final double digitHeight;
  final Color? backgroundColor;

  const RollingDigitCounter({
    super.key,
    required this.value,
    this.decimals = 0,
    this.duration = const Duration(milliseconds: 1000),
    this.style,
    this.autoplay = true,
    this.keepAlive = true,
    this.digitWidth = 28,
    this.digitHeight = 40,
    this.backgroundColor,
  });

  @override
  State<RollingDigitCounter> createState() => _RollingDigitCounterState();
}

class _RollingDigitCounterState extends State<RollingDigitCounter>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;
  late AnimationController _controller;
  num _oldValue = 0;
  String _currentChars = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.addListener(_onTick);
    _currentChars = _formatValue(widget.value);
    if (widget.autoplay) {
      _controller.forward();
    }
  }

  void _onTick() {
    setState(() {
      final t = _controller.value;
      final old = _oldValue.toDouble();
      final target = widget.value.toDouble();
      final current = old + (target - old) * t;
      _currentChars = _formatValue(current);
    });
  }

  String _formatValue(num v) {
    if (widget.decimals > 0) {
      return v.toStringAsFixed(widget.decimals);
    }
    return (v.round()).toString();
  }

  @override
  void didUpdateWidget(RollingDigitCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = _oldValue =
          _oldValue + (oldWidget.value - _oldValue) * _controller.value;
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final style = widget.style ?? const TextStyle(fontSize: 24);
    final effectiveStyle = style.copyWith(
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < _currentChars.length; i++)
          _DigitBox(
            char: _currentChars[i],
            style: effectiveStyle,
            width: widget.digitWidth,
            height: widget.digitHeight,
            backgroundColor: widget.backgroundColor,
          ),
      ],
    );
  }
}

class _DigitBox extends StatelessWidget {
  final String char;
  final TextStyle style;
  final double width;
  final double height;
  final Color? backgroundColor;

  const _DigitBox({
    required this.char,
    required this.style,
    required this.width,
    required this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade900,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(char, style: style),
      ),
    );
  }
}
