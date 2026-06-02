import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'text_effect.dart';
import 'text_effect_controller.dart';
import 'character_animation.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  final List<TextEffect> effects;
  final TextEffectController? controller;
  final TextStyle? style;
  final TextAlign textAlign;
  final bool autoplay;
  final bool repeat;
  final bool reverse;
  final TextDirection textDirection;
  final StrutStyle? strutStyle;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis textWidthBasis;

  const AnimatedText(
    this.text, {
    super.key,
    this.effects = const [],
    this.controller,
    this.style,
    this.textAlign = TextAlign.start,
    this.autoplay = true,
    this.repeat = false,
    this.reverse = false,
    this.textDirection = TextDirection.ltr,
    this.strutStyle,
    this.textHeightBehavior,
    this.textWidthBasis = TextWidthBasis.parent,
  });

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Duration _calculateDuration() {
    final charCount = widget.text.length;
    if (widget.effects.isEmpty || charCount == 0) return Duration.zero;
    return widget.effects
        .map((e) => e.getTotalDuration(charCount))
        .reduce((a, b) => a > b ? a : b);
  }

  @override
  void initState() {
    super.initState();
    final duration = _calculateDuration();
    _controller = AnimationController(vsync: this, duration: duration);

    if (widget.controller != null) {
      widget.controller!.animationController = _controller;
    }

    if (duration > Duration.zero) {
      if (widget.autoplay && widget.repeat) {
        _controller.repeat(reverse: widget.reverse);
      } else if (widget.autoplay) {
        _controller.forward();
      }
    }
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller!.animationController = null;
      }
      if (widget.controller != null) {
        widget.controller!.animationController = _controller;
      }
    }
    final newDuration = _calculateDuration();
    if (newDuration != _controller.duration) {
      _controller.duration = newDuration;
    }
  }

  List<CharacterAnimation> _computeAnimations() {
    final charCount = widget.text.length;
    final progress = _controller.value;

    if (widget.effects.isEmpty || charCount == 0) {
      return List.generate(
        charCount,
        (_) => const CharacterAnimation(),
      );
    }

    final result = List<CharacterAnimation>.generate(
      charCount,
      (_) => const CharacterAnimation(),
    );

    for (final effect in widget.effects) {
      final effectAnimations = effect.getAnimations(progress, charCount);
      for (int i = 0; i < charCount; i++) {
        result[i] = result[i].combine(effectAnimations[i]);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? DefaultTextStyle.of(context).style;
    final animations = _computeAnimations();

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth =
            constraints.hasBoundedWidth ? constraints.maxWidth : double.infinity;

        final tp = TextPainter(
          text: TextSpan(text: widget.text, style: effectiveStyle),
          textDirection: widget.textDirection,
          textAlign: widget.textAlign,
          strutStyle: widget.strutStyle,
          textHeightBehavior: widget.textHeightBehavior,
          textWidthBasis: widget.textWidthBasis,
        )..layout(maxWidth: maxWidth);

        final positions = <int, Offset>{};
        for (int i = 0; i < widget.text.length; i++) {
          final boxes = tp.getBoxesForSelection(
            TextSelection(baseOffset: i, extentOffset: i + 1),
          );
          if (boxes.isNotEmpty) {
            positions[i] = Offset(boxes.first.left, boxes.first.top);
          }
        }

        return SizedBox(
          width: tp.width,
          height: tp.height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ...List.generate(widget.text.length, (i) {
                final char = widget.text[i];
                if (char == ' ' || char == '\n' || char == '\t') {
                  return const SizedBox.shrink();
                }

                final anim = animations[i];
                final pos = positions[i];
                if (pos == null) return const SizedBox.shrink();

                Widget charWidget = Text(
                  char,
                  style: effectiveStyle.copyWith(
                    color: anim.color ?? effectiveStyle.color,
                  ),
                  textDirection: widget.textDirection,
                );

                if (anim.blurSigma > 0) {
                  charWidget = ImageFiltered(
                    imageFilter: ui.ImageFilter.blur(
                      sigmaX: anim.blurSigma,
                      sigmaY: anim.blurSigma,
                    ),
                    child: charWidget,
                  );
                }

                if (anim.opacity < 1.0) {
                  charWidget = Opacity(
                    opacity: anim.opacity,
                    child: charWidget,
                  );
                }

                if (anim.translation != Offset.zero) {
                  charWidget = Transform.translate(
                    offset: anim.translation,
                    child: charWidget,
                  );
                }
                if (anim.scale != 1.0) {
                  charWidget = Transform.scale(
                    scale: anim.scale,
                    alignment: Alignment.topLeft,
                    child: charWidget,
                  );
                }

                return Positioned(
                  left: pos.dx,
                  top: pos.dy,
                  child: charWidget,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
