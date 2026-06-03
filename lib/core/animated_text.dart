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
  final bool keepAlive;

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
    this.keepAlive = true,
  });

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => widget.keepAlive;
  late AnimationController _controller;

  Duration _calculateDuration() {
    final charCount = widget.text.length;
    if (widget.effects.isEmpty || charCount == 0) return Duration.zero;
    return widget.effects
        .map((e) => e.getTotalDuration(charCount))
        .reduce((a, b) => a > b ? a : b);
  }

  void _onTick() => setState(() {});

  void _initController(Duration duration) {
    if (widget.controller != null) {
      widget.controller!.attach(this, duration, _onTick);
      _controller = widget.controller!.animationController!;
    } else {
      _controller = AnimationController(vsync: this, duration: duration);
      if (duration > Duration.zero) {
        if (widget.autoplay && widget.repeat) {
          _controller.repeat(reverse: widget.reverse);
        } else if (widget.autoplay) {
          _controller.forward();
        }
      }
      _controller.addListener(_onTick);
    }
  }

  @override
  void initState() {
    super.initState();
    _initController(_calculateDuration());
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.detach();
    } else {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      if (oldWidget.controller != null) {
        oldWidget.controller!.detach();
      }
      if (widget.controller != null) {
        widget.controller!.attach(this, _calculateDuration(), _onTick);
        _controller = widget.controller!.animationController!;
      } else {
        _controller = AnimationController(vsync: this, duration: _calculateDuration());
        if (widget.autoplay && widget.repeat) {
          _controller.repeat(reverse: widget.reverse);
        } else if (widget.autoplay) {
          _controller.forward();
        }
        _controller.addListener(_onTick);
      }
      return;
    }

    final effectsChanged = oldWidget.effects != widget.effects;
    final textChanged = oldWidget.text != widget.text;
    final repeatChanged = oldWidget.repeat != widget.repeat ||
        oldWidget.reverse != widget.reverse;

    if (effectsChanged || textChanged || repeatChanged) {
      _controller.duration = _calculateDuration();
      if (_controller.duration != null && _controller.duration! > Duration.zero) {
        _controller.reset();
        if (widget.repeat) {
          _controller.repeat(reverse: widget.reverse);
        } else if (widget.autoplay) {
          _controller.forward();
        }
      }
    } else {
      final newDuration = _calculateDuration();
      if (newDuration != _controller.duration) {
        _controller.duration = newDuration;
      }
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
    super.build(context);
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

        final charRects = <int, Rect>{};
        for (int i = 0; i < widget.text.length; i++) {
          final boxes = tp.getBoxesForSelection(
            TextSelection(baseOffset: i, extentOffset: i + 1),
          );
          if (boxes.isNotEmpty) {
            final b = boxes.first;
            charRects[i] = b.toRect();
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
                final rect = charRects[i];
                if (rect == null) return const SizedBox.shrink();

                Widget charWidget = Text(
                  char,
                  style: effectiveStyle.copyWith(
                    color: anim.color ?? effectiveStyle.color,
                  ),
                  textDirection: widget.textDirection,
                );

                if (anim.backgroundColor != null) {
                  charWidget = Container(
                    color: anim.backgroundColor,
                    child: charWidget,
                  );
                }

                Widget clipContent = charWidget;

                if (anim.blurSigma > 0) {
                  clipContent = ImageFiltered(
                    imageFilter: ui.ImageFilter.blur(
                      sigmaX: anim.blurSigma,
                      sigmaY: anim.blurSigma,
                    ),
                    child: clipContent,
                  );
                }

                if (anim.opacity < 1.0) {
                  clipContent = Opacity(
                    opacity: anim.opacity,
                    child: clipContent,
                  );
                }

                if (anim.translation != Offset.zero) {
                  clipContent = Transform.translate(
                    offset: anim.translation,
                    child: clipContent,
                  );
                }
                final sx = anim.scale * anim.scaleX;
                final sy = anim.scale * anim.scaleY;
                if (sx != 1.0 || sy != 1.0) {
                  clipContent = Transform(
                    alignment: Alignment.topLeft,
                    transform: Matrix4.diagonal3Values(sx, sy, 1),
                    child: clipContent,
                  );
                }

                if (anim.rotation != 0.0) {
                  clipContent = Transform.rotate(
                    angle: anim.rotation,
                    child: clipContent,
                  );
                }

                if (anim.rotationX != 0.0) {
                  clipContent = Transform(
                    alignment: Alignment.topLeft,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(anim.rotationX),
                    child: clipContent,
                  );
                }

                if (anim.rotationY != 0.0) {
                  clipContent = Transform(
                    alignment: Alignment.topLeft,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(anim.rotationY),
                    child: clipContent,
                  );
                }

                if (anim.clipProgress < 1.0) {
                  clipContent = ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: anim.clipProgress.clamp(0.0, 1.0),
                      child: clipContent,
                    ),
                  );
                }

                return Positioned(
                  left: rect.left,
                  top: rect.top,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      clipContent,
                      if (anim.underlineProgress > 0)
                        Positioned(
                          left: 0,
                          top: rect.height,
                          child: Container(
                            width: rect.width * anim.underlineProgress.clamp(0.0, 1.0),
                            height: 2,
                            color: anim.color ?? effectiveStyle.color,
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
