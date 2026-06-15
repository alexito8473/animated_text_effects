import 'package:flutter/painting.dart';

/// Per-character animation state produced by a [TextEffect].
///
/// Contains all visual properties that can be animated per character:
/// opacity, translation, scaling, color, blur, rotation, underline, and clip.
///
/// Multiple [CharacterAnimation] instances are combined with [combine] using
/// well-defined rules:
/// - opacity, scale, scaleX, scaleY, clipProgress are **multiplied**
/// - translation, blurSigma, rotation, rotationX, rotationY, underlineProgress are **summed**
/// - color, backgroundColor use **last non-null wins**
class CharacterAnimation {
  /// Character opacity (0.0 = transparent, 1.0 = opaque).
  final double opacity;

  /// Offset translation applied to the character.
  final Offset translation;

  /// Uniform scale factor applied before [scaleX] and [scaleY].
  final double scale;

  /// Horizontal scale factor applied after [scale].
  final double scaleX;

  /// Vertical scale factor applied after [scale].
  final double scaleY;

  /// Text color override. If null, the inherited style color is used.
  final Color? color;

  /// Background color rendered behind the character.
  final Color? backgroundColor;

  /// Gaussian blur sigma (0.0 = no blur).
  final double blurSigma;

  /// 2D rotation angle in radians around the character's origin.
  final double rotation;

  /// 3D rotation angle in radians around the X axis.
  final double rotationX;

  /// 3D rotation angle in radians around the Y axis.
  final double rotationY;

  /// Underline draw progress from 0.0 (hidden) to 1.0 (full width).
  final double underlineProgress;

  /// Clip reveal progress from 0.0 (fully hidden) to 1.0 (fully visible).
  final double clipProgress;

  /// Optional character override. When set, this character is displayed
  /// instead of the original text character (e.g. for scramble effects).
  final String? character;

  /// Creates a [CharacterAnimation] with all properties defaulting to
  /// identity values (no animation applied).
  ///
  /// Parameters default to identity values: opacity=1, translation=zero,
  /// scale=1, blur=0, rotation=0, clipProgress=1, character=null.
  const CharacterAnimation({
    this.opacity = 1.0,
    this.translation = Offset.zero,
    this.scale = 1.0,
    this.scaleX = 1.0,
    this.scaleY = 1.0,
    this.color,
    this.backgroundColor,
    this.blurSigma = 0.0,
    this.rotation = 0.0,
    this.rotationX = 0.0,
    this.rotationY = 0.0,
    this.underlineProgress = 0.0,
    this.clipProgress = 1.0,
    this.character,
  });

  /// Combined horizontal scale factor: [scale] × [scaleX].
  double get uniformScale => scale * scaleX;

  /// Merges this animation with [other] using composition rules.
  ///
  /// Properties that compound (opacity, scale) are multiplied.
  /// Additive properties (translation, rotation, blur) are summed.
  /// Color and backgroundColor fall back to the last non-null value.
  ///
  /// [other] — the [CharacterAnimation] to combine into this one.
  CharacterAnimation combine(CharacterAnimation other) {
    return CharacterAnimation(
      opacity: opacity * other.opacity,
      translation: translation + other.translation,
      scale: scale * other.scale,
      scaleX: scaleX * other.scaleX,
      scaleY: scaleY * other.scaleY,
      color: other.color ?? color,
      backgroundColor: other.backgroundColor ?? backgroundColor,
      blurSigma: blurSigma + other.blurSigma,
      rotation: rotation + other.rotation,
      rotationX: rotationX + other.rotationX,
      rotationY: rotationY + other.rotationY,
      underlineProgress: underlineProgress + other.underlineProgress,
      clipProgress: clipProgress * other.clipProgress,
      character: other.character ?? character,
    );
  }
}
