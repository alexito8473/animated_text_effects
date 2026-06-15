import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'character_animation.dart';

/// Renders animated text by placing each character at its measured position
/// with per-character transforms (blur, opacity, translate, scale, rotate, clip).
///
/// Uses [LayoutBuilder] and [TextPainter] to measure character positions
/// from the styled full text, then overlays individual [Text] widgets with
/// transforms derived from each [CharacterAnimation].
class AnimatedTextRender extends StatelessWidget {
  /// The full text string to render.
  final String text;

  /// Per-character animation states (must match [text] length).
  final List<CharacterAnimation> animations;

  /// Base text style applied to every character.
  final TextStyle textStyle;

  /// Text direction for layout.
  final TextDirection textDirection;

  /// Horizontal text alignment.
  final TextAlign textAlign;

  /// Optional strut style for consistent line height.
  final StrutStyle? strutStyle;

  /// Optional text height behavior override.
  final TextHeightBehavior? textHeightBehavior;

  /// How text width is computed relative to the parent.
  final TextWidthBasis textWidthBasis;

  /// Creates an [AnimatedTextRender] to paint animated character positions.
  ///
  /// [text] — the full text string (required).
  /// [animations] — per-character animation data (required, same length as text).
  /// [textStyle] — base style for rendering (required).
  /// [textDirection] — layout direction (required).
  /// [textAlign] — horizontal alignment.
  /// [strutStyle] — optional strut for line height.
  /// [textHeightBehavior] — optional height behavior override.
  /// [textWidthBasis] — how text width is computed.
  const AnimatedTextRender({
    super.key,
    required this.text,
    required this.animations,
    required this.textStyle,
    required this.textDirection,
    this.textAlign = TextAlign.start,
    this.strutStyle,
    this.textHeightBehavior,
    this.textWidthBasis = TextWidthBasis.parent,
  });

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty || animations.isEmpty) return const SizedBox.shrink();

    // Use LayoutBuilder to get the available width, then measure all
    // character bounding boxes with TextPainter before laying them out.
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : double.infinity;

        // Measure the full text once to get each character's position.
        final tp = TextPainter(
          text: TextSpan(text: text, style: textStyle),
          textDirection: textDirection,
          textAlign: textAlign,
          strutStyle: strutStyle,
          textHeightBehavior: textHeightBehavior,
          textWidthBasis: textWidthBasis,
        )..layout(maxWidth: maxWidth);

        // Extract per-character bounding rectangles from the laid-out text.
        final charRects = <int, Rect>{};
        for (int i = 0; i < text.length; i++) {
          final boxes = tp.getBoxesForSelection(
            TextSelection(baseOffset: i, extentOffset: i + 1),
          );
          if (boxes.isNotEmpty) {
            charRects[i] = boxes.first.toRect();
          }
        }

        return SizedBox(
          width: tp.width,
          height: tp.height,
          child: Stack(
            clipBehavior: Clip.none,
            children: List.generate(text.length, (i) {
              final char = animations[i].character ?? text[i];
              // Whitespace characters are skipped — they contribute no visual.
              if (char == ' ' || char == '\n' || char == '\t') {
                return const SizedBox.shrink();
              }

              final anim = animations[i];
              final rect = charRects[i];
              if (rect == null) return const SizedBox.shrink();

              // Base character widget with optional color override.
              Widget charWidget = Text(
                char,
                style: textStyle.copyWith(
                  color: anim.color ?? textStyle.color,
                ),
                textDirection: textDirection,
              );

              // Wrap in background color container if set.
              if (anim.backgroundColor != null) {
                charWidget = Container(
                  color: anim.backgroundColor,
                  child: charWidget,
                );
              }

              // Transform pipeline: blur → opacity → translate → scale → rotate → clip.
              // Each stage wraps the previous so the operations compose correctly.
              Widget clipContent = charWidget;

              // 1. Gaussian blur (applied first so blur doesn't affect other transforms).
              if (anim.blurSigma > 0) {
                clipContent = ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(
                    sigmaX: anim.blurSigma,
                    sigmaY: anim.blurSigma,
                  ),
                  child: clipContent,
                );
              }

              // 2. Opacity fade.
              if (anim.opacity < 1.0) {
                clipContent = Opacity(
                  opacity: anim.opacity,
                  child: clipContent,
                );
              }

              // 3. Translation (offset position).
              if (anim.translation != Offset.zero) {
                clipContent = Transform.translate(
                  offset: anim.translation,
                  child: clipContent,
                );
              }

              // 4. Scale (uniform × per-axis).
              final sx = anim.scale * anim.scaleX;
              final sy = anim.scale * anim.scaleY;
              if (sx != 1.0 || sy != 1.0) {
                clipContent = Transform(
                  alignment: Alignment.topLeft,
                  transform: Matrix4.diagonal3Values(sx, sy, 1),
                  child: clipContent,
                );
              }

              // 5. 2D rotation (Z-axis).
              if (anim.rotation != 0.0) {
                clipContent = Transform.rotate(
                  angle: anim.rotation,
                  child: clipContent,
                );
              }

              // 6. 3D rotation around X axis (setEntry prevents z-fighting).
              if (anim.rotationX != 0.0) {
                clipContent = Transform(
                  alignment: Alignment.topLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(anim.rotationX),
                  child: clipContent,
                );
              }

              // 7. 3D rotation around Y axis.
              if (anim.rotationY != 0.0) {
                clipContent = Transform(
                  alignment: Alignment.topLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(anim.rotationY),
                  child: clipContent,
                );
              }

              // 8. Clip reveal (horizontal wipe from left).
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
                          width: rect.width *
                              anim.underlineProgress.clamp(0.0, 1.0),
                          height: 2,
                          color: anim.color ?? textStyle.color,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
