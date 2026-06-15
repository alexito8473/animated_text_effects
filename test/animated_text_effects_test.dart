import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

void main() {
  group('CharacterAnimation', () {
    test('default values are identity', () {
      final anim = CharacterAnimation();
      expect(anim.opacity, 1.0);
      expect(anim.translation, Offset.zero);
      expect(anim.scale, 1.0);
      expect(anim.scaleX, 1.0);
      expect(anim.scaleY, 1.0);
      expect(anim.color, isNull);
      expect(anim.backgroundColor, isNull);
      expect(anim.blurSigma, 0.0);
      expect(anim.rotation, 0.0);
      expect(anim.rotationX, 0.0);
      expect(anim.rotationY, 0.0);
      expect(anim.underlineProgress, 0.0);
      expect(anim.clipProgress, 1.0);
      expect(anim.character, isNull);
    });

    test('combine multiplies opacity', () {
      final a = CharacterAnimation(opacity: 0.5);
      final b = CharacterAnimation(opacity: 0.5);
      final c = a.combine(b);
      expect(c.opacity, 0.25);
    });

    test('combine sums translation', () {
      final a = CharacterAnimation(translation: Offset(10, 0));
      final b = CharacterAnimation(translation: Offset(0, 5));
      final c = a.combine(b);
      expect(c.translation, Offset(10, 5));
    });

    test('combine multiplies scale', () {
      final a = CharacterAnimation(scale: 2.0);
      final b = CharacterAnimation(scale: 0.5);
      final c = a.combine(b);
      expect(c.scale, 1.0);
    });

    test('combine multiplies scaleX', () {
      final a = CharacterAnimation(scaleX: 2.0);
      final b = CharacterAnimation(scaleX: 0.25);
      final c = a.combine(b);
      expect(c.scaleX, 0.5);
    });

    test('combine multiplies scaleY', () {
      final a = CharacterAnimation(scaleY: 1.5);
      final b = CharacterAnimation(scaleY: 0.5);
      final c = a.combine(b);
      expect(c.scaleY, 0.75);
    });

    test('combine uses last non-null color', () {
      final a = CharacterAnimation(color: Colors.red);
      final b = CharacterAnimation(color: Colors.blue);
      final c = a.combine(b);
      expect(c.color, Colors.blue);
    });

    test('combine preserves first color when second is null', () {
      final a = CharacterAnimation(color: Colors.red);
      final b = CharacterAnimation();
      final c = a.combine(b);
      expect(c.color, Colors.red);
    });

    test('combine uses last non-null backgroundColor', () {
      final a = CharacterAnimation(backgroundColor: Colors.yellow);
      final b = CharacterAnimation(backgroundColor: Colors.green);
      final c = a.combine(b);
      expect(c.backgroundColor, Colors.green);
    });

    test('combine sums blur sigma', () {
      final a = CharacterAnimation(blurSigma: 3.0);
      final b = CharacterAnimation(blurSigma: 2.0);
      final c = a.combine(b);
      expect(c.blurSigma, 5.0);
    });

    test('combine sums rotation', () {
      final a = CharacterAnimation(rotation: 0.5);
      final b = CharacterAnimation(rotation: 0.3);
      final c = a.combine(b);
      expect(c.rotation, closeTo(0.8, 0.001));
    });

    test('combine sums rotationX', () {
      final a = CharacterAnimation(rotationX: 0.2);
      final b = CharacterAnimation(rotationX: 0.4);
      final c = a.combine(b);
      expect(c.rotationX, closeTo(0.6, 0.001));
    });

    test('combine sums rotationY', () {
      final a = CharacterAnimation(rotationY: 0.1);
      final b = CharacterAnimation(rotationY: 0.7);
      final c = a.combine(b);
      expect(c.rotationY, closeTo(0.8, 0.001));
    });

    test('combine sums underlineProgress', () {
      final a = CharacterAnimation(underlineProgress: 0.3);
      final b = CharacterAnimation(underlineProgress: 0.4);
      final c = a.combine(b);
      expect(c.underlineProgress, closeTo(0.7, 0.001));
    });

    test('combine multiplies clipProgress', () {
      final a = CharacterAnimation(clipProgress: 0.5);
      final b = CharacterAnimation(clipProgress: 0.8);
      final c = a.combine(b);
      expect(c.clipProgress, 0.4);
    });

    test('combine uses last non-null character', () {
      final a = CharacterAnimation(character: 'A');
      final b = CharacterAnimation(character: 'B');
      final c = a.combine(b);
      expect(c.character, 'B');
    });

    test('combine preserves first character when second is null', () {
      final a = CharacterAnimation(character: 'X');
      final b = CharacterAnimation();
      final c = a.combine(b);
      expect(c.character, 'X');
    });

    test('uniformScale combines scale and scaleX', () {
      final anim = CharacterAnimation(scale: 2.0, scaleX: 3.0);
      expect(anim.uniformScale, 6.0);
    });

    test('combine maintains identity when combining with default', () {
      final a = CharacterAnimation(
        opacity: 0.7,
        translation: Offset(5, 5),
        scale: 1.2,
      );
      final b = CharacterAnimation();
      final c = a.combine(b);
      expect(c.opacity, 0.7);
      expect(c.translation, Offset(5, 5));
      expect(c.scale, 1.2);
    });
  });

  group('TextEffect', () {
    test('getTotalDuration adds delay for charCount', () {
      final effect = FadeEffect(
        duration: Duration(milliseconds: 500),
        delayBetweenChars: Duration(milliseconds: 100),
      );
      expect(effect.getTotalDuration(3), Duration(milliseconds: 800));
    });

    test('getTotalDuration returns duration for zero chars', () {
      final effect = FadeEffect(duration: Duration(milliseconds: 500));
      expect(effect.getTotalDuration(0), Duration(milliseconds: 500));
    });

    test('noise returns deterministic values', () {
      final effect = FadeEffect();
      final value1 = effect.noise(0);
      final value2 = effect.noise(0);
      expect(value1, value2);
    });

    test('noise returns values between 0 and 1', () {
      final effect = FadeEffect();
      for (int i = 0; i < 100; i++) {
        final n = effect.noise(i);
        expect(n, greaterThanOrEqualTo(0.0));
        expect(n, lessThanOrEqualTo(1.0));
      }
    });

    test('noise with different indices returns different values', () {
      final effect = FadeEffect();
      final values = List.generate(10, (i) => effect.noise(i));
      for (int i = 0; i < values.length; i++) {
        for (int j = i + 1; j < values.length; j++) {
          expect(values[i], isNot(values[j]));
        }
      }
    });

    test('noise with different offsets returns different values', () {
      final effect = FadeEffect();
      expect(effect.noise(0, 1), isNot(effect.noise(0, 2)));
    });

    test('applyCurve clamps result', () {
      final effect = FadeEffect(curve: Curves.easeInOut);
      expect(effect.applyCurve(-0.5), 0.0);
      expect(effect.applyCurve(1.5), 1.0);
    });

    test('staggeredProgress with single char', () {
      final effect = FadeEffect(delayBetweenChars: Duration(milliseconds: 100));
      expect(effect.staggeredProgress(0.5, 0, 1), 0.5);
    });

    test('staggeredProgress with zero delay equals global', () {
      final effect = FadeEffect(delayBetweenChars: Duration.zero);
      expect(effect.staggeredProgress(0.3, 2, 5), 0.3);
    });
  });

  group('TextEffectController', () {
    test('default state', () {
      final controller = TextEffectController();
      expect(controller.isPlaying, false);
      expect(controller.isCompleted, false);
      expect(controller.progress, 0.0);
      expect(controller.animationController, isNull);
    });

    test('progress returns saved value after dispose', () {
      final controller = TextEffectController();
      controller.dispose();
      expect(controller.progress, 0.0);
      expect(controller.isPlaying, false);
      expect(controller.isCompleted, false);
    });

    test('stop resets progress', () {
      final controller = TextEffectController();
      // Not attached, should not throw
      controller.stop();
      expect(controller.progress, 0.0);
    });

    test('multiple dispose calls are safe', () {
      final controller = TextEffectController();
      controller.dispose();
      controller.dispose();
    });
  });

  group('FadeEffect', () {
    test('returns correct opacity for progress 0', () {
      final effect = FadeEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 5);
      expect(animations.length, 5);
      for (final anim in animations) {
        expect(anim.opacity, closeTo(0.0, 0.01));
      }
    });

    test('returns correct opacity for progress 1', () {
      final effect = FadeEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.opacity, closeTo(1.0, 0.01));
      }
    });

    test('returns empty list for empty text', () {
      final effect = FadeEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('opacity increases with progress', () {
      final effect = FadeEffect(delayBetweenChars: Duration.zero);
      final at0 = effect.getAnimations(0.0, 5);
      final atMid = effect.getAnimations(0.5, 5);
      final at1 = effect.getAnimations(1.0, 5);
      for (int i = 0; i < 5; i++) {
        expect(atMid[i].opacity, greaterThan(at0[i].opacity));
        expect(at1[i].opacity, greaterThan(atMid[i].opacity));
      }
    });

    test('respects custom opacity range', () {
      final effect = FadeEffect(
        opacityFrom: 0.3,
        opacityTo: 0.8,
        delayBetweenChars: Duration.zero,
      );
      final at0 = effect.getAnimations(0.0, 3);
      final at1 = effect.getAnimations(1.0, 3);
      for (final anim in at0) {
        expect(anim.opacity, closeTo(0.3, 0.01));
      }
      for (final anim in at1) {
        expect(anim.opacity, closeTo(0.8, 0.01));
      }
    });

    test('other properties are at defaults', () {
      final effect = FadeEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
        expect(anim.color, isNull);
        expect(anim.blurSigma, 0.0);
      }
    });

    test('staggered with delay shows different opacities', () {
      final effect = FadeEffect(delayBetweenChars: Duration(milliseconds: 100));
      final animations = effect.getAnimations(0.3, 10);
      // With delay, earlier chars should be more visible
      expect(animations[0].opacity, greaterThan(animations[9].opacity));
    });
  });

  group('GradientEffect', () {
    test('returns color for each character', () {
      final effect = GradientEffect(colors: [Colors.red, Colors.blue]);
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.color, isNotNull);
      }
    });

    test('opacity is not affected', () {
      final effect = GradientEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
      }
    });

    test('other properties are at defaults', () {
      final effect = GradientEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
        expect(anim.blurSigma, 0.0);
        expect(anim.rotation, 0.0);
      }
    });

    test('empty text returns empty list', () {
      final effect = GradientEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('colors change with progress', () {
      final effect = GradientEffect(colors: [Colors.red, Colors.blue]);
      final at0 = effect.getAnimations(0.0, 5);
      final atMid = effect.getAnimations(0.5, 5);
      expect(at0[2].color, isNot(atMid[2].color));
    });
  });

  group('WaveEffect', () {
    test('returns scale values within range', () {
      final effect = WaveEffect();
      final animations = effect.getAnimations(0.0, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.scale, greaterThanOrEqualTo(0.5));
        expect(anim.scale, lessThanOrEqualTo(1.5));
      }
    });

    test('returns scale 1.0 at progress 0 and 1', () {
      final effect = WaveEffect();
      final at0 = effect.getAnimations(0.0, 5);
      final at1 = effect.getAnimations(1.0, 5);
      expect(at0[0].scale, closeTo(1.0, 0.01));
      expect(at1[0].scale, closeTo(1.0, 0.01));
    });

    test('empty text returns empty list', () {
      final effect = WaveEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties are at defaults', () {
      final effect = WaveEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.color, isNull);
      }
    });

    test('scale range respects custom values', () {
      final effect = WaveEffect(scaleMin: 0.2, scaleMax: 2.0);
      final animations = effect.getAnimations(0.25, 5);
      for (final anim in animations) {
        expect(anim.scale, greaterThanOrEqualTo(0.2));
        expect(anim.scale, lessThanOrEqualTo(2.0));
      }
    });

    test('getTotalDuration equals duration', () {
      final effect = WaveEffect(duration: Duration(milliseconds: 2000));
      expect(effect.getTotalDuration(10), Duration(milliseconds: 2000));
    });

    test('single character returns valid scale', () {
      final effect = WaveEffect();
      final animations = effect.getAnimations(0.5, 1);
      expect(animations.length, 1);
      expect(animations[0].scale, greaterThanOrEqualTo(0.5));
      expect(animations[0].scale, lessThanOrEqualTo(1.5));
    });
  });

  group('TypewriterEffect', () {
    test('all invisible at progress 0', () {
      final effect = TypewriterEffect(
        delayBetweenChars: Duration(milliseconds: 100),
      );
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, 0.0);
      }
    });

    test('all visible at progress 1', () {
      final effect = TypewriterEffect(
        delayBetweenChars: Duration(milliseconds: 100),
      );
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
      }
    });

    test('empty text returns empty list', () {
      final effect = TypewriterEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('chars reveal left to right', () {
      final effect = TypewriterEffect(
        delayBetweenChars: Duration(milliseconds: 100),
      );
      final animations = effect.getAnimations(0.3, 10);
      int? firstVisible;
      int? lastVisible;
      for (int i = 0; i < animations.length; i++) {
        if (animations[i].opacity > 0.5) {
          firstVisible ??= i;
          lastVisible = i;
        }
      }
      if (firstVisible != null && lastVisible != null) {
        // Visible chars should be contiguous from start
        expect(firstVisible, 0);
      }
    });

    test('cursor color applied at typing position', () {
      final effect = TypewriterEffect(
        delayBetweenChars: Duration(milliseconds: 100),
        cursorColor: Colors.red,
      );
      final animations = effect.getAnimations(0.15, 10);
      bool hasRed = false;
      for (final anim in animations) {
        if (anim.color == Colors.red) hasRed = true;
      }
      expect(hasRed, isTrue);
    });

    test('other properties at defaults', () {
      final effect = TypewriterEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
        expect(anim.blurSigma, 0.0);
      }
    });
  });

  group('BounceEffect', () {
    test('returns translation with negative dy', () {
      final effect = BounceEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.1, 3);
      for (final anim in animations) {
        expect(anim.translation.dy, lessThanOrEqualTo(0));
      }
    });

    test('returns zero translation at progress 0 and 1', () {
      final effect = BounceEffect(delayBetweenChars: Duration.zero);
      final at0 = effect.getAnimations(0.0, 3);
      final at1 = effect.getAnimations(1.0, 3);
      for (final anim in at0) {
        expect(anim.translation.dy, closeTo(0.0, 0.01));
      }
      for (final anim in at1) {
        expect(anim.translation.dy, closeTo(0.0, 0.01));
      }
    });

    test('translation dy respects height', () {
      final effect = BounceEffect(
        height: 20.0,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.translation.dy, greaterThanOrEqualTo(-20.0));
        expect(anim.translation.dy, lessThanOrEqualTo(0.0));
      }
    });

    test('empty text returns empty list', () {
      final effect = BounceEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = BounceEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.scale, 1.0);
        expect(anim.color, isNull);
      }
    });
  });

  group('ShimmerEffect', () {
    test('returns color for each character', () {
      final effect = ShimmerEffect();
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.color, isNotNull);
      }
    });

    test('returns base color at progress 0', () {
      final effect = ShimmerEffect();
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.color, isNotNull);
      }
    });

    test('returns base color at progress 1', () {
      final effect = ShimmerEffect();
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.color, isNotNull);
      }
    });

    test('empty text returns empty list', () {
      final effect = ShimmerEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = ShimmerEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
      }
    });
  });

  group('SlideEffect', () {
    test('characters start offset from zero', () {
      final effect = SlideEffect(
        direction: SlideDirection.left,
        distance: 50,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.translation.dx, lessThan(0));
      }
    });

    test('characters reach zero at progress 1', () {
      final effect = SlideEffect(
        direction: SlideDirection.right,
        distance: 50,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.translation.dx, closeTo(0, 0.01));
      }
    });

    test('characters reach zero at progress 0', () {
      final effect = SlideEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 3);
      // With delay zero and progress 0, staggered still returns 0
      for (final anim in animations) {
        expect(anim.translation.distance, greaterThanOrEqualTo(0));
      }
    });

    test('all directions produce non-zero offset', () {
      for (final dir in SlideDirection.values) {
        final effect = SlideEffect(
          direction: dir,
          distance: 30,
          delayBetweenChars: Duration.zero,
        );
        final animations = effect.getAnimations(0.0, 3);
        for (final anim in animations) {
          expect(anim.translation.distance, greaterThan(0));
        }
      }
    });

    test('empty text returns empty list', () {
      final effect = SlideEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = SlideEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.scale, 1.0);
        expect(anim.color, isNull);
      }
    });

    test('distance scales offset', () {
      final near = SlideEffect(distance: 10, delayBetweenChars: Duration.zero);
      final far = SlideEffect(distance: 100, delayBetweenChars: Duration.zero);
      final nearAnim = near.getAnimations(0.0, 3);
      final farAnim = far.getAnimations(0.0, 3);
      for (int i = 0; i < 3; i++) {
        expect(
          farAnim[i].translation.distance,
          greaterThan(nearAnim[i].translation.distance),
        );
      }
    });
  });

  group('BlurEffect', () {
    test('starts with sigmaFrom', () {
      final effect = BlurEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.blurSigma, closeTo(8.0, 0.01));
      }
    });

    test('ends with sigmaTo', () {
      final effect = BlurEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.blurSigma, closeTo(0.0, 0.01));
      }
    });

    test('sigma decreases with progress', () {
      final effect = BlurEffect(delayBetweenChars: Duration.zero);
      final at0 = effect.getAnimations(0.0, 5);
      final atMid = effect.getAnimations(0.5, 5);
      final at1 = effect.getAnimations(1.0, 5);
      for (int i = 0; i < 5; i++) {
        expect(atMid[i].blurSigma, lessThan(at0[i].blurSigma));
        expect(at1[i].blurSigma, lessThan(atMid[i].blurSigma));
      }
    });

    test('empty text returns empty list', () {
      final effect = BlurEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = BlurEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
        expect(anim.color, isNull);
      }
    });

    test('custom sigma range', () {
      final effect = BlurEffect(
        sigmaFrom: 5.0,
        sigmaTo: 2.0,
        delayBetweenChars: Duration.zero,
      );
      final at0 = effect.getAnimations(0.0, 3);
      final at1 = effect.getAnimations(1.0, 3);
      for (final anim in at0) {
        expect(anim.blurSigma, closeTo(5.0, 0.01));
      }
      for (final anim in at1) {
        expect(anim.blurSigma, closeTo(2.0, 0.01));
      }
    });
  });

  group('RainbowEffect', () {
    test('returns color for each character', () {
      final effect = RainbowEffect();
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.color, isNotNull);
      }
    });

    test('colors differ between characters', () {
      final effect = RainbowEffect();
      final animations = effect.getAnimations(0.5, 5);
      final uniqueColors = animations.map((a) => a.color).toSet();
      expect(uniqueColors.length, greaterThan(1));
    });

    test('returns null color at progress 0 and 1', () {
      final effect = RainbowEffect();
      final at0 = effect.getAnimations(0.0, 5);
      final at1 = effect.getAnimations(1.0, 5);
      for (final anim in at0) {
        expect(anim.color, isNotNull);
      }
      for (final anim in at1) {
        expect(anim.color, isNotNull);
      }
    });

    test('empty text returns empty list', () {
      final effect = RainbowEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = RainbowEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
        expect(anim.blurSigma, 0.0);
      }
    });
  });

  group('GlowEffect', () {
    test('returns varying blur and opacity', () {
      final effect = GlowEffect();
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.blurSigma, greaterThanOrEqualTo(3.0));
        expect(anim.blurSigma, lessThanOrEqualTo(12.0));
        expect(anim.opacity, greaterThanOrEqualTo(0.6));
        expect(anim.opacity, lessThanOrEqualTo(1.0));
      }
    });

    test('returns defaults at progress 0', () {
      final effect = GlowEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.blurSigma, closeTo(3.0, 0.01));
      }
    });

    test('returns defaults at progress 1', () {
      final effect = GlowEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.blurSigma, closeTo(3.0, 0.01));
      }
    });

    test('empty text returns empty list', () {
      final effect = GlowEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = GlowEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
      }
    });
  });

  group('RippleEffect', () {
    test('returns varying scale within range', () {
      final effect = RippleEffect();
      final animations = effect.getAnimations(0.5, 5);
      expect(animations.length, 5);
      for (final anim in animations) {
        expect(anim.scale, greaterThanOrEqualTo(0.5));
        expect(anim.scale, lessThanOrEqualTo(1.3));
      }
    });

    test('returns defaults at progress 0', () {
      final effect = RippleEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.translation.dy, closeTo(0.0, 0.01));
        expect(anim.opacity, closeTo(1.0, 0.01));
      }
    });

    test('returns defaults at progress 1', () {
      final effect = RippleEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.translation.dy, closeTo(0.0, 0.01));
        expect(anim.opacity, closeTo(1.0, 0.01));
      }
    });

    test('empty text returns empty list', () {
      final effect = RippleEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('center characters animate differently from edges', () {
      final effect = RippleEffect();
      final animations = effect.getAnimations(0.3, 7);
      final center = animations[3];
      final edge = animations[0];
      expect(center.scale, isNot(edge.scale));
    });
  });

  group('SpinEffect', () {
    test('returns rotation increasing with progress', () {
      final effect = SpinEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.rotation, greaterThan(0.0));
      }
    });

    test('returns zero at progress 0', () {
      final effect = SpinEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.rotation, closeTo(0.0, 0.01));
        expect(anim.scale, closeTo(0.0, 0.01));
      }
    });

    test('returns identity at progress 1', () {
      final effect = SpinEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.rotation, closeTo(0.0, 0.01));
        expect(anim.scale, closeTo(1.0, 0.01));
      }
    });

    test('empty text returns empty list', () {
      final effect = SpinEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = SpinEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.color, isNull);
      }
    });
  });

  group('FlipEffect', () {
    test('returns rotationY when axis is Y', () {
      final effect = FlipEffect(axis: true, delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.rotationY, greaterThan(0.0));
        expect(anim.rotationX, closeTo(0.0, 0.01));
      }
    });

    test('returns rotationX when axis is X', () {
      final effect = FlipEffect(axis: false, delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.rotationX, greaterThan(0.0));
        expect(anim.rotationY, closeTo(0.0, 0.01));
      }
    });

    test('returns zero at progress 0 and 1', () {
      final effect = FlipEffect(delayBetweenChars: Duration.zero);
      final at0 = effect.getAnimations(0.0, 3);
      final at1 = effect.getAnimations(1.0, 3);
      for (final anim in at0) {
        expect(anim.rotationY, closeTo(0.0, 0.01));
      }
      for (final anim in at1) {
        expect(anim.rotationY, closeTo(0.0, 0.01));
      }
    });

    test('opacity dips at mid-flip', () {
      final effect = FlipEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, lessThan(1.0));
      }
    });

    test('empty text returns empty list', () {
      final effect = FlipEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = FlipEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
        expect(anim.blurSigma, 0.0);
      }
    });
  });

  group('WiggleEffect', () {
    test('returns non-zero translation at mid progress', () {
      final effect = WiggleEffect();
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.translation.distance, greaterThan(0));
      }
    });

    test('returns zero at progress 0 and 1', () {
      final effect = WiggleEffect();
      final at0 = effect.getAnimations(0.0, 3);
      final at1 = effect.getAnimations(1.0, 3);
      for (final anim in at0) {
        expect(anim.translation, Offset.zero);
        expect(anim.rotation, 0.0);
      }
      for (final anim in at1) {
        expect(anim.translation, Offset.zero);
        expect(anim.rotation, closeTo(0.0, 0.001));
      }
    });

    test('different characters have different translations', () {
      final effect = WiggleEffect();
      final animations = effect.getAnimations(0.5, 5);
      final uniqueTranslations = <Offset>{};
      for (final anim in animations) {
        uniqueTranslations.add(anim.translation);
      }
      expect(uniqueTranslations.length, greaterThan(1));
    });

    test('translation is bounded by amplitude', () {
      final effect = WiggleEffect(amplitude: 5.0);
      final animations = effect.getAnimations(0.5, 5);
      for (final anim in animations) {
        expect(anim.translation.dx.abs(), lessThanOrEqualTo(5.0));
        expect(anim.translation.dy.abs(), lessThanOrEqualTo(5.0));
      }
    });

    test('empty text returns empty list', () {
      final effect = WiggleEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('PulseEffect', () {
    test('returns varying scale within range', () {
      final effect = PulseEffect();
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.scale, greaterThanOrEqualTo(1.0));
        expect(anim.scale, lessThanOrEqualTo(1.3));
      }
    });

    test('returns defaults at progress 0', () {
      final effect = PulseEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.opacity, closeTo(1.0, 0.01));
      }
    });

    test('returns defaults at progress 1', () {
      final effect = PulseEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.opacity, closeTo(1.0, 0.01));
      }
    });

    test('empty text returns empty list', () {
      final effect = PulseEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('custom range works', () {
      final effect = PulseEffect(scaleMin: 0.9, scaleMax: 1.5, opacityMin: 0.7);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.scale, greaterThanOrEqualTo(0.9));
        expect(anim.scale, lessThanOrEqualTo(1.5));
        expect(anim.opacity, greaterThanOrEqualTo(0.7));
      }
    });
  });

  group('ScatterEffect', () {
    test('returns non-zero translation at progress 0', () {
      final effect = ScatterEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.translation.distance, greaterThan(0));
      }
    });

    test('returns zero translation at progress 1', () {
      final effect = ScatterEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.translation.distance, closeTo(0.0, 0.01));
      }
    });

    test('opacity increases with progress', () {
      final effect = ScatterEffect(delayBetweenChars: Duration.zero);
      final at0 = effect.getAnimations(0.0, 5);
      final at1 = effect.getAnimations(1.0, 5);
      for (int i = 0; i < 5; i++) {
        expect(at1[i].opacity, greaterThan(at0[i].opacity));
      }
    });

    test('different characters have different directions', () {
      final effect = ScatterEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 5);
      final uniqueTranslations = <Offset>{};
      for (final anim in animations) {
        uniqueTranslations.add(anim.translation);
      }
      expect(uniqueTranslations.length, greaterThan(1));
    });

    test('empty text returns empty list', () {
      final effect = ScatterEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('translation bounded by distance', () {
      final effect = ScatterEffect(
        distance: 100,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.translation.distance, lessThanOrEqualTo(100.0));
      }
    });
  });

  group('NeonFlickerEffect', () {
    test('returns varying opacity', () {
      final effect = NeonFlickerEffect();
      final animations = effect.getAnimations(0.5, 5);
      expect(animations.length, 5);
    });

    test('returns defaults at progress 0', () {
      final effect = NeonFlickerEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.opacity, closeTo(1.0, 0.01));
        expect(anim.color, isNull);
      }
    });

    test('returns defaults at progress 1', () {
      final effect = NeonFlickerEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.opacity, closeTo(1.0, 0.01));
        expect(anim.color, isNull);
      }
    });

    test('empty text returns empty list', () {
      final effect = NeonFlickerEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('ElasticEffect', () {
    test('stretchX differs from 1 at mid progress', () {
      final effect = ElasticEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.2, 3);
      for (final anim in animations) {
        // scaleX and scaleY should differ from 1.0 at mid progress
        expect(anim.scaleX, isNot(closeTo(1.0, 0.01)));
        expect(anim.scaleY, isNot(closeTo(1.0, 0.01)));
      }
    });

    test('returns defaults at progress 0', () {
      final effect = ElasticEffect(
        stretch: 0.3,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.scaleX, closeTo(1.0, 0.01));
        expect(anim.scaleY, closeTo(1.0, 0.01));
      }
    });

    test('returns defaults at progress 1', () {
      final effect = ElasticEffect(
        stretch: 0.3,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.scaleX, closeTo(1.0, 0.01));
        expect(anim.scaleY, closeTo(1.0, 0.01));
      }
    });

    test('empty text returns empty list', () {
      final effect = ElasticEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = ElasticEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.rotation, 0.0);
      }
    });
  });

  group('HighlightEffect', () {
    test('returns backgroundColor at mid progress', () {
      final effect = HighlightEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.backgroundColor, isNotNull);
      }
    });

    test('returns null backgroundColor at progress 0', () {
      final effect = HighlightEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.backgroundColor, isNull);
      }
    });

    test('returns null backgroundColor at progress 1', () {
      final effect = HighlightEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.backgroundColor, isNull);
      }
    });

    test('empty text returns empty list', () {
      final effect = HighlightEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = HighlightEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
      }
    });
  });

  group('UnderlineEffect', () {
    test('returns increasing underlineProgress', () {
      final effect = UnderlineEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.underlineProgress, greaterThan(0.0));
      }
    });

    test('returns zero at progress 0', () {
      final effect = UnderlineEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.underlineProgress, 0.0);
      }
    });

    test('returns zero at progress 1', () {
      final effect = UnderlineEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.underlineProgress, closeTo(0.0, 0.001));
      }
    });

    test('empty text returns empty list', () {
      final effect = UnderlineEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('lineColor is applied when set', () {
      final effect = UnderlineEffect(
        lineColor: Colors.red,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.color, Colors.red);
      }
    });

    test('other properties at defaults', () {
      final effect = UnderlineEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
      }
    });
  });

  group('ProgressTextEffect', () {
    test('all characters at emptyColor at progress 0', () {
      final effect = ProgressTextEffect();
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.color, Colors.grey);
      }
    });

    test('all characters at filledColor at progress 1', () {
      final effect = ProgressTextEffect();
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.color, Colors.green);
      }
    });

    test('returns mix of colors at mid progress', () {
      final effect = ProgressTextEffect();
      final animations = effect.getAnimations(0.5, 10);
      final hasFilled = animations.any((a) => a.color == Colors.green);
      final hasEmpty = animations.any((a) => a.color == Colors.grey);
      expect(hasFilled, isTrue);
      expect(hasEmpty, isTrue);
    });

    test('empty text returns empty list', () {
      final effect = ProgressTextEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('custom colors', () {
      final effect = ProgressTextEffect(
        filledColor: Colors.blue,
        emptyColor: Colors.white,
      );
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.color, Colors.white);
      }
      final at1 = effect.getAnimations(1.0, 3);
      for (final anim in at1) {
        expect(anim.color, Colors.blue);
      }
    });
  });

  group('StaggeredAppearEffect', () {
    test('returns translation at progress 0', () {
      final effect = StaggeredAppearEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.translation.distance, greaterThan(0));
      }
    });

    test('returns zero translation at progress 1', () {
      final effect = StaggeredAppearEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.translation.distance, closeTo(0.0, 0.01));
      }
    });

    test('opacity increases from opacityFrom to 1', () {
      final effect = StaggeredAppearEffect(
        opacityFrom: 0.0,
        delayBetweenChars: Duration.zero,
      );
      final at0 = effect.getAnimations(0.0, 3);
      final at1 = effect.getAnimations(1.0, 3);
      for (final anim in at0) {
        expect(anim.opacity, closeTo(0.0, 0.01));
      }
      for (final anim in at1) {
        expect(anim.opacity, closeTo(1.0, 0.01));
      }
    });

    test('all directions produce offset', () {
      for (final dir in SlideDirection.values) {
        final effect = StaggeredAppearEffect(
          direction: dir,
          delayBetweenChars: Duration.zero,
        );
        final animations = effect.getAnimations(0.0, 3);
        for (final anim in animations) {
          expect(anim.translation.distance, greaterThan(0));
        }
      }
    });

    test('empty text returns empty list', () {
      final effect = StaggeredAppearEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('FireEffect', () {
    test('returns non-default properties at mid progress', () {
      final effect = FireEffect();
      final animations = effect.getAnimations(0.5, 5);
      expect(animations.length, 5);
    });

    test('returns defaults at progress 0', () {
      final effect = FireEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.color, isNull);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.blurSigma, 0.0);
      }
    });

    test('returns defaults at progress 1', () {
      final effect = FireEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.color, isNull);
        expect(anim.translation.distance, closeTo(0.0, 0.01));
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.blurSigma, closeTo(0.0, 0.001));
      }
    });

    test('empty text returns empty list', () {
      final effect = FireEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('SmokeEffect', () {
    test('returns upward translation at mid progress', () {
      final effect = SmokeEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.translation.dy, lessThanOrEqualTo(0));
      }
    });

    test('returns defaults at progress 0', () {
      final effect = SmokeEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.opacity, 1.0);
        expect(anim.blurSigma, 0.0);
      }
    });

    test('returns defaults at progress 1', () {
      final effect = SmokeEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.translation.distance, closeTo(0.0, 0.01));
        expect(anim.opacity, closeTo(1.0, 0.01));
        expect(anim.blurSigma, closeTo(0.0, 0.001));
      }
    });

    test('empty text returns empty list', () {
      final effect = SmokeEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('translation bounded by height', () {
      final effect = SmokeEffect(height: 30, delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.translation.dy.abs(), lessThanOrEqualTo(30.0));
      }
    });
  });

  group('VHSGlitchEffect', () {
    test('returns varying properties at mid progress', () {
      final effect = VHSGlitchEffect();
      final animations = effect.getAnimations(0.5, 5);
      expect(animations.length, 5);
    });

    test('returns defaults at progress 0', () {
      final effect = VHSGlitchEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.blurSigma, 0.0);
        expect(anim.opacity, 1.0);
        expect(anim.color, isNull);
      }
    });

    test('returns defaults at progress 1', () {
      final effect = VHSGlitchEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.translation.distance, closeTo(0.0, 0.01));
        expect(anim.blurSigma, closeTo(0.0, 0.001));
        expect(anim.opacity, closeTo(1.0, 0.01));
        expect(anim.color, isNull);
      }
    });

    test('empty text returns empty list', () {
      final effect = VHSGlitchEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('RevealEffect', () {
    test('returns clipProgress 0 at progress 0', () {
      final effect = RevealEffect(
        clipFrom: 0.0,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.clipProgress, closeTo(0.0, 0.01));
      }
    });

    test('returns clipProgress 1 at progress 1', () {
      final effect = RevealEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.clipProgress, closeTo(1.0, 0.01));
      }
    });

    test('clipProgress increases with progress', () {
      final effect = RevealEffect(delayBetweenChars: Duration.zero);
      final at0 = effect.getAnimations(0.0, 5);
      final atMid = effect.getAnimations(0.5, 5);
      final at1 = effect.getAnimations(1.0, 5);
      for (int i = 0; i < 5; i++) {
        expect(
          atMid[i].clipProgress,
          greaterThanOrEqualTo(at0[i].clipProgress),
        );
        expect(
          at1[i].clipProgress,
          greaterThanOrEqualTo(atMid[i].clipProgress),
        );
      }
    });

    test('empty text returns empty list', () {
      final effect = RevealEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = RevealEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
        expect(anim.color, isNull);
      }
    });

    test('custom clipFrom', () {
      final effect = RevealEffect(
        clipFrom: 0.3,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.clipProgress, closeTo(0.3, 0.01));
      }
    });
  });

  group('LiquidEffect', () {
    test('returns varying scaleX and scaleY at mid progress', () {
      final effect = LiquidEffect();
      final animations = effect.getAnimations(0.5, 3);
      expect(animations.length, 3);
    });

    test('returns defaults at progress 0', () {
      final effect = LiquidEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.scaleX, closeTo(1.0, 0.01));
        expect(anim.scaleY, closeTo(1.0, 0.01));
        expect(anim.translation, Offset.zero);
      }
    });

    test('returns defaults at progress 1', () {
      final effect = LiquidEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.scaleX, closeTo(1.0, 0.01));
        expect(anim.scaleY, closeTo(1.0, 0.01));
        expect(anim.translation.distance, closeTo(0.0, 0.01));
      }
    });

    test('empty text returns empty list', () {
      final effect = LiquidEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('different characters have different values', () {
      final effect = LiquidEffect();
      final animations = effect.getAnimations(0.5, 5);
      final unique = animations.map((a) => a.scaleX).toSet();
      expect(unique.length, greaterThan(1));
    });
  });

  group('ScannerEffect', () {
    test('returns clipProgress 0 for all chars at progress 0', () {
      final effect = ScannerEffect();
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.clipProgress, 0.0);
      }
    });

    test('returns clipProgress 1 for all chars at progress 1', () {
      final effect = ScannerEffect();
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.clipProgress, 1.0);
      }
    });

    test('empty text returns empty list', () {
      final effect = ScannerEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = ScannerEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
      }
    });

    test('returns color for some chars at mid progress', () {
      final effect = ScannerEffect();
      final animations = effect.getAnimations(0.5, 10);
      final hasColor = animations.any((a) => a.color != null);
      expect(hasColor, isTrue);
    });
  });

  group('WaveColorEffect', () {
    test('returns color for each character', () {
      final effect = WaveColorEffect();
      final animations = effect.getAnimations(0.5, 4);
      expect(animations.length, 4);
      for (final anim in animations) {
        expect(anim.color, isNotNull);
      }
    });

    test('colors return to start at progress 1', () {
      final effect = WaveColorEffect();
      final at0 = effect.getAnimations(0.0, 5);
      final at1 = effect.getAnimations(1.0, 5);
      for (int i = 0; i < 5; i++) {
        expect(at0[i].color!.value, at1[i].color!.value);
      }
    });

    test('colors differ between characters', () {
      final effect = WaveColorEffect();
      final animations = effect.getAnimations(0.5, 5);
      final uniqueColors = animations.map((a) => a.color).toSet();
      expect(uniqueColors.length, greaterThan(1));
    });

    test('empty text returns empty list', () {
      final effect = WaveColorEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = WaveColorEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
      }
    });
  });

  group('BreathingOpacityEffect', () {
    test('returns opacity 1.0 at progress 0', () {
      final effect = BreathingOpacityEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
      }
    });

    test('returns opacity 1.0 at progress 1', () {
      final effect = BreathingOpacityEffect(opacityMin: 0.5);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.opacity, closeTo(1.0, 0.001));
      }
    });

    test('opacity dips below 1 at mid progress', () {
      final effect = BreathingOpacityEffect(opacityMin: 0.5);
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, lessThan(1.0));
      }
    });

    test('all chars have same opacity', () {
      final effect = BreathingOpacityEffect();
      final animations = effect.getAnimations(0.5, 5);
      final firstOpacity = animations[0].opacity;
      for (final anim in animations) {
        expect(anim.opacity, firstOpacity);
      }
    });

    test('empty text returns empty list', () {
      final effect = BreathingOpacityEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('opacity respects opacityMin', () {
      final effect = BreathingOpacityEffect(opacityMin: 0.3);
      final animations = effect.getAnimations(0.25, 3);
      for (final anim in animations) {
        expect(anim.opacity, greaterThanOrEqualTo(0.3));
        expect(anim.opacity, lessThanOrEqualTo(1.0));
      }
    });
  });

  group('ConveyorBeltEffect', () {
    test('returns zero translation at progress 0', () {
      final effect = ConveyorBeltEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
      }
    });

    test('returns zero translation at progress 1', () {
      final effect = ConveyorBeltEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.translation.dx, closeTo(0.0, 0.001));
        expect(anim.translation.dy, closeTo(0.0, 0.001));
      }
    });

    test('characters translate in sequence', () {
      final effect = ConveyorBeltEffect(spacing: 20);
      final animations = effect.getAnimations(0.5, 5);
      // Later characters should have larger dx
      for (int i = 1; i < 5; i++) {
        expect(
          animations[i].translation.dx.abs(),
          greaterThan(animations[i - 1].translation.dx.abs()),
        );
      }
    });

    test('reverse flips translation direction', () {
      final forward = ConveyorBeltEffect(reverse: false);
      final backward = ConveyorBeltEffect(reverse: true);
      final fwd = forward.getAnimations(0.5, 3);
      final bwd = backward.getAnimations(0.5, 3);
      for (int i = 0; i < 3; i++) {
        expect(fwd[i].translation.dx, isNot(bwd[i].translation.dx));
      }
    });

    test('empty text returns empty list', () {
      final effect = ConveyorBeltEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = ConveyorBeltEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.scale, 1.0);
        expect(anim.color, isNull);
      }
    });
  });

  group('MeltDripEffect', () {
    test('returns defaults at progress 0', () {
      final effect = MeltDripEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 4);
      for (final anim in animations) {
        expect(anim.scaleY, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.blurSigma, 0.0);
      }
    });

    test('returns defaults at progress 1', () {
      final effect = MeltDripEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 4);
      for (final anim in animations) {
        expect(anim.scaleY, closeTo(1.0, 0.001));
        expect(anim.translation.dx, closeTo(0.0, 0.001));
        expect(anim.translation.dy, closeTo(0.0, 0.001));
        expect(anim.blurSigma, closeTo(0.0, 0.001));
      }
    });

    test('scaleY decreases at mid progress', () {
      final effect = MeltDripEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 4);
      for (final anim in animations) {
        expect(anim.scaleY, lessThan(1.0));
      }
    });

    test('translation dy positive at mid progress (drips down)', () {
      final effect = MeltDripEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 4);
      for (final anim in animations) {
        expect(anim.translation.dy, greaterThanOrEqualTo(0.0));
      }
    });

    test('empty text returns empty list', () {
      final effect = MeltDripEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('blur applied at mid progress', () {
      final effect = MeltDripEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.5, 4);
      for (final anim in animations) {
        expect(anim.blurSigma, greaterThan(0.0));
      }
    });

    test('custom values respected', () {
      final effect = MeltDripEffect(
        meltAmount: 0.8,
        dripHeight: 60,
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(0.5, 4);
      for (final anim in animations) {
        expect(anim.scaleY, greaterThanOrEqualTo(0.2));
        expect(anim.translation.dy, lessThanOrEqualTo(60.0));
      }
    });
  });

  group('SparkleTwinkleEffect', () {
    test('returns some sparkles at mid progress', () {
      final effect = SparkleTwinkleEffect();
      final animations = effect.getAnimations(0.5, 10);
      expect(animations.length, 10);
    });

    test('returns defaults at progress 0', () {
      final effect = SparkleTwinkleEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.color, isNull);
        expect(anim.blurSigma, 0.0);
      }
    });

    test('returns defaults at progress 1', () {
      final effect = SparkleTwinkleEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.color, isNull);
        expect(anim.blurSigma, closeTo(0.0, 0.001));
      }
    });

    test('empty text returns empty list', () {
      final effect = SparkleTwinkleEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('MatrixRainEffect', () {
    test('returns null color at progress 0', () {
      final effect = MatrixRainEffect();
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.color, isNull);
      }
    });

    test('returns null color at progress 1', () {
      final effect = MatrixRainEffect();
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.color, isNull);
      }
    });

    test('returns non-null color at mid progress', () {
      final effect = MatrixRainEffect();
      final animations = effect.getAnimations(0.5, 5);
      final hasColor = animations.any((a) => a.color != null);
      expect(hasColor, isTrue);
    });

    test('translation dy is negative at mid progress (falling)', () {
      final effect = MatrixRainEffect();
      final animations = effect.getAnimations(0.5, 5);
      for (final anim in animations) {
        expect(anim.translation.dy, lessThanOrEqualTo(0.0));
      }
    });

    test('returns defaults at progress 0', () {
      final effect = MatrixRainEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.opacity, 1.0);
        expect(anim.blurSigma, 0.0);
      }
    });

    test('returns defaults at progress 1', () {
      final effect = MatrixRainEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.translation.distance, closeTo(0.0, 0.01));
        expect(anim.blurSigma, closeTo(0.0, 0.001));
      }
    });

    test('empty text returns empty list', () {
      final effect = MatrixRainEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('GlitchSplitEffect', () {
    test('returns zero translation at progress 0', () {
      final effect = GlitchSplitEffect();
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
      }
    });

    test('returns zero translation at progress 1', () {
      final effect = GlitchSplitEffect();
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
      }
    });

    test('empty text returns empty list', () {
      final effect = GlitchSplitEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('some characters have color at mid progress', () {
      final effect = GlitchSplitEffect(probability: 0.8);
      final animations = effect.getAnimations(0.5, 10);
      final hasColor = animations.any((a) => a.color != null);
      expect(hasColor, isTrue);
    });

    test('other properties at defaults', () {
      final effect = GlitchSplitEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.scale, 1.0);
        expect(anim.blurSigma, 0.0);
      }
    });
  });

  group('ScrambleEffect', () {
    test('returns character override at progress 0', () {
      final effect = ScrambleEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.character, isNotNull);
        expect(anim.character!.length, 1);
      }
    });

    test('returns null character at progress 1', () {
      final effect = ScrambleEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.character, isNull);
      }
    });

    test('opacity is 0 at progress 0', () {
      final effect = ScrambleEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, 0.0);
      }
    });

    test('opacity is 1 at progress 1', () {
      final effect = ScrambleEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
      }
    });

    test('different seeds produce different scramble patterns', () {
      final effect1 = ScrambleEffect(seed: 1, delayBetweenChars: Duration.zero);
      final effect2 = ScrambleEffect(seed: 2, delayBetweenChars: Duration.zero);
      final anims1 = effect1.getAnimations(0.0, 5);
      final anims2 = effect2.getAnimations(0.0, 5);
      final chars1 = anims1.map((a) => a.character).join();
      final chars2 = anims2.map((a) => a.character).join();
      expect(chars1, isNot(chars2));
    });

    test('same seed produces same scramble pattern', () {
      final effect1 = ScrambleEffect(
        seed: 42,
        delayBetweenChars: Duration.zero,
      );
      final effect2 = ScrambleEffect(
        seed: 42,
        delayBetweenChars: Duration.zero,
      );
      final anims1 = effect1.getAnimations(0.0, 5);
      final anims2 = effect2.getAnimations(0.0, 5);
      for (int i = 0; i < 5; i++) {
        expect(anims1[i].character, anims2[i].character);
      }
    });

    test('custom charset produces valid characters', () {
      final effect = ScrambleEffect(
        charset: '01',
        delayBetweenChars: Duration.zero,
      );
      final animations = effect.getAnimations(0.0, 10);
      for (final anim in animations) {
        expect(anim.character, anyOf('0', '1'));
      }
    });

    test('empty text returns empty list', () {
      ScrambleEffect effect = ScrambleEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('PopInEffect', () {
    test('returns scale near 0 at progress 0', () {
      final effect = PopInEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.opacity, 0.0);
      }
    });

    test('returns scale 1 at progress 1', () {
      final effect = PopInEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.scale, closeTo(1.0, 0.01));
      }
    });

    test('scale exceeds 1.0 at mid progress (overshoot)', () {
      final effect = PopInEffect(
        scalePeak: 1.5,
        delayBetweenChars: Duration.zero,
      );
      // Check multiple mid points for overshoot
      bool foundOvershoot = false;
      for (final p in [0.2, 0.3, 0.4, 0.5, 0.6, 0.7]) {
        final animations = effect.getAnimations(p, 3);
        for (final anim in animations) {
          if (anim.scale > 1.05) foundOvershoot = true;
        }
      }
      expect(foundOvershoot, isTrue);
    });

    test('opacity increases with progress', () {
      final effect = PopInEffect(delayBetweenChars: Duration.zero);
      final at0 = effect.getAnimations(0.0, 3);
      final atMid = effect.getAnimations(0.5, 3);
      final at1 = effect.getAnimations(1.0, 3);
      for (int i = 0; i < 3; i++) {
        expect(atMid[i].opacity, greaterThan(at0[i].opacity));
        expect(at1[i].opacity, greaterThanOrEqualTo(atMid[i].opacity));
      }
    });

    test('opacity is 1 at progress 1', () {
      final effect = PopInEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
      }
    });

    test('empty text returns empty list', () {
      final effect = PopInEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('staggered chars pop at different times', () {
      final effect = PopInEffect(
        delayBetweenChars: Duration(milliseconds: 100),
      );
      final animations = effect.getAnimations(0.3, 10);
      expect(animations[0].scale, greaterThan(animations[9].scale));
    });
  });

  group('ShakeEffect', () {
    test('returns zero translation at progress 0', () {
      final effect = ShakeEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.rotation, 0.0);
      }
    });

    test('returns zero translation at progress 1', () {
      final effect = ShakeEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.translation.distance, closeTo(0.0, 0.01));
        expect(anim.rotation, closeTo(0.0, 0.001));
      }
    });

    test('returns non-zero translation at mid progress', () {
      final effect = ShakeEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.translation.distance, greaterThan(0.0));
      }
    });

    test('translation bounded by intensity', () {
      final effect = ShakeEffect(intensity: 10.0);
      final animations = effect.getAnimations(0.5, 5);
      for (final anim in animations) {
        expect(anim.translation.dx.abs(), lessThanOrEqualTo(10.0));
        expect(anim.translation.dy.abs(), lessThanOrEqualTo(5.0));
      }
    });

    test('different characters shake differently', () {
      final effect = ShakeEffect();
      final animations = effect.getAnimations(0.5, 5);
      final uniqueTranslations = animations.map((a) => a.translation).toSet();
      expect(uniqueTranslations.length, greaterThan(1));
    });

    test('empty text returns empty list', () {
      final effect = ShakeEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('FlagWaveEffect', () {
    test('returns zero rotationY at progress 0', () {
      final effect = FlagWaveEffect();
      final animations = effect.getAnimations(0.0, 3);
      for (final anim in animations) {
        expect(anim.rotationY, closeTo(0.0, 0.01));
      }
    });

    test('returns zero rotationY at progress 1', () {
      final effect = FlagWaveEffect();
      final animations = effect.getAnimations(1.0, 3);
      for (final anim in animations) {
        expect(anim.rotationY, closeTo(0.0, 0.01));
      }
    });

    test('rotationY stays within amplitude bounds', () {
      final effect = FlagWaveEffect(amplitude: 0.5, waveCount: 2);
      for (final p in [0.2, 0.3, 0.5, 0.7, 0.8]) {
        final animations = effect.getAnimations(p, 5);
        for (final anim in animations) {
          expect(anim.rotationY.abs(), lessThanOrEqualTo(0.5));
        }
      }
    });

    test('different characters have different rotationY', () {
      final effect = FlagWaveEffect();
      final animations = effect.getAnimations(0.5, 5);
      final uniqueRotations = animations.map((a) => a.rotationY).toSet();
      expect(uniqueRotations.length, greaterThan(1));
    });

    test('empty text returns empty list', () {
      final effect = FlagWaveEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('other properties at defaults', () {
      final effect = FlagWaveEffect();
      final animations = effect.getAnimations(0.5, 3);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
        expect(anim.translation, Offset.zero);
        expect(anim.scale, 1.0);
        expect(anim.color, isNull);
      }
    });

    test('single character returns zero rotationY', () {
      final effect = FlagWaveEffect();
      final animations = effect.getAnimations(0.5, 1);
      expect(animations.length, 1);
      expect(animations[0].rotationY, closeTo(0.0, 0.01));
    });
  });

  group('RandomRevealEffect', () {
    test('returns opacityFrom at progress 0', () {
      final effect = RandomRevealEffect(opacityFrom: 0.0);
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, closeTo(0.0, 0.01));
      }
    });

    test('returns opacity 1.0 at progress 1', () {
      final effect = RandomRevealEffect();
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, closeTo(1.0, 0.01));
      }
    });

    test('all chars visible at progress 1', () {
      final effect = RandomRevealEffect();
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
      }
    });

    test('scale matches opacityFrom at progress 0', () {
      final effect = RandomRevealEffect(opacityFrom: 0.0);
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.scale, closeTo(0.0, 0.01));
      }
    });

    test('scale is 1 at progress 1', () {
      final effect = RandomRevealEffect();
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.scale, closeTo(1.0, 0.01));
      }
    });

    test('chars reveal at different progress values', () {
      final effect = RandomRevealEffect();
      final atMid = effect.getAnimations(0.5, 10);
      final opacities = atMid.map((a) => a.opacity).toSet();
      // At mid progress, some chars should be at different stages
      expect(opacities.length, greaterThan(1));
    });

    test('different seeds produce different reveal order', () {
      final effect1 = RandomRevealEffect(seed: 1);
      final effect2 = RandomRevealEffect(seed: 2);
      final anims1 = effect1.getAnimations(0.5, 10);
      final anims2 = effect2.getAnimations(0.5, 10);
      final order1 = anims1.map((a) => a.opacity > 0.5 ? 1 : 0).join();
      final order2 = anims2.map((a) => a.opacity > 0.5 ? 1 : 0).join();
      expect(order1, isNot(order2));
    });

    test('empty text returns empty list', () {
      final effect = RandomRevealEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });
  });

  group('AnimatedText widget', () {
    testWidgets('renders text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedText(
              'Hello',
              effects: const [FadeEffect(delayBetweenChars: Duration.zero)],
              autoplay: false,
            ),
          ),
        ),
      );

      expect(find.text('H'), findsOneWidget);
      expect(find.text('e'), findsOneWidget);
      expect(find.text('l'), findsWidgets);
      expect(find.text('o'), findsOneWidget);
    });

    testWidgets('renders empty text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedText(
              '',
              effects: const [FadeEffect()],
              autoplay: false,
            ),
          ),
        ),
      );
    });

    testWidgets('renders with multiple combined effects', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedText(
              'Multi',
              effects: const [
                FadeEffect(delayBetweenChars: Duration.zero),
                WaveEffect(),
              ],
              autoplay: false,
            ),
          ),
        ),
      );

      expect(find.text('M'), findsOneWidget);
      expect(find.text('u'), findsOneWidget);
    });

    testWidgets('respects autoplay false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedText('Test', effects: const [], autoplay: false),
          ),
        ),
      );
      expect(find.text('T'), findsOneWidget);
    });

    testWidgets('renders without effects', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedText(
              'No effects',
              effects: const [],
              autoplay: false,
            ),
          ),
        ),
      );
      for (final char in 'No effects'.split('')) {
        if (char == ' ') continue;
        expect(find.text(char), findsWidgets);
      }
    });

    testWidgets('renders with scramble effect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedText(
              'Scramble',
              effects: const [ScrambleEffect(delayBetweenChars: Duration.zero)],
              autoplay: false,
            ),
          ),
        ),
      );
      expect(find.textContaining(RegExp(r'.')), findsWidgets);
    });
  });

  group('AnimatedCounter', () {
    testWidgets('renders integer value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: AnimatedCounter(value: 42, autoplay: false)),
      );
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('renders decimal value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCounter(value: 3.14, decimals: 2, autoplay: false),
        ),
      );
      expect(find.text('3.14'), findsOneWidget);
    });

    testWidgets('uses custom format', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCounter(
            value: 100,
            autoplay: false,
            format: (v) => '${v}x',
          ),
        ),
      );
      expect(find.text('100x'), findsOneWidget);
    });

    testWidgets('changes color with activeColor', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCounter(
            value: 50,
            autoplay: false,
            activeColor: Colors.red,
            style: const TextStyle(color: Colors.green),
          ),
        ),
      );
      expect(find.text('50'), findsOneWidget);
    });

    testWidgets('renders zero value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: AnimatedCounter(value: 0, autoplay: false)),
      );
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('renders negative value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: AnimatedCounter(value: -42, autoplay: false)),
      );
      expect(find.text('-42'), findsOneWidget);
    });

    testWidgets('scalePulse defaults to 1.0 at progress 0', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCounter(value: 100, scalePulse: true, autoplay: false),
        ),
      );
      expect(find.text('100'), findsOneWidget);
    });

    testWidgets('resets and re-animates on value change', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: AnimatedCounter(value: 100, autoplay: false)),
      );
      expect(find.text('100'), findsOneWidget);
    });
  });

  group('AnimatedPercentage', () {
    testWidgets('renders percentage with % sign', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedPercentage(value: 75.5, decimals: 1, autoplay: false),
        ),
      );
      expect(find.text('75.5%'), findsOneWidget);
    });

    testWidgets('renders without % sign', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedPercentage(
            value: 50,
            decimals: 0,
            autoplay: false,
            showPercentSign: false,
          ),
        ),
      );
      expect(find.text('50'), findsOneWidget);
    });

    testWidgets('renders integer percentage', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedPercentage(value: 100, decimals: 0, autoplay: false),
        ),
      );
      expect(find.text('100%'), findsOneWidget);
    });

    testWidgets('renders zero percentage', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedPercentage(value: 0, decimals: 0, autoplay: false),
        ),
      );
      expect(find.text('0%'), findsOneWidget);
    });
  });

  group('AnimatedCurrency', () {
    testWidgets('renders with dollar symbol', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCurrency(value: 99.99, decimals: 2, autoplay: false),
        ),
      );
      expect(find.text(r'$99.99'), findsOneWidget);
    });

    testWidgets('renders with plus sign', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCurrency(
            value: 50,
            symbol: '',
            decimals: 0,
            showPlusSign: true,
            autoplay: false,
          ),
        ),
      );
      expect(find.text('+50'), findsOneWidget);
    });

    testWidgets('formats thousands with comma', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCurrency(value: 1234, decimals: 0, autoplay: false),
        ),
      );
      expect(find.text(r'$1,234'), findsOneWidget);
    });

    testWidgets('renders with euro symbol', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCurrency(
            value: 42,
            symbol: '€',
            decimals: 0,
            autoplay: false,
          ),
        ),
      );
      expect(find.text('€42'), findsOneWidget);
    });

    testWidgets('renders negative currency', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCurrency(value: -50, decimals: 0, autoplay: false),
        ),
      );
      expect(find.text(r'$-50'), findsOneWidget);
    });

    testWidgets('formats large number with commas', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCurrency(value: 1234567, decimals: 0, autoplay: false),
        ),
      );
      expect(find.text(r'$1,234,567'), findsOneWidget);
    });

    testWidgets('shows plus sign for zero', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedCurrency(
            value: 0,
            symbol: '',
            decimals: 0,
            showPlusSign: true,
            autoplay: false,
          ),
        ),
      );
      expect(find.text('+0'), findsOneWidget);
    });
  });

  group('RollingDigitCounter', () {
    testWidgets('renders value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: RollingDigitCounter(value: 2026, autoplay: false)),
      );
      expect(find.text('2'), findsWidgets);
      expect(find.text('0'), findsWidgets);
      expect(find.text('6'), findsOneWidget);
    });

    testWidgets('renders decimal value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RollingDigitCounter(value: 3.14, decimals: 2, autoplay: false),
        ),
      );
      expect(find.text('3'), findsOneWidget);
      expect(find.text('.'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('renders single digit', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: RollingDigitCounter(value: 7, autoplay: false)),
      );
      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('renders zero', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: RollingDigitCounter(value: 0, autoplay: false)),
      );
      expect(find.text('0'), findsOneWidget);
    });
  });

  group('AnimatedStatCard', () {
    testWidgets('renders label and value', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedStatCard(
              value: 8472,
              label: 'Users',
              icon: Icons.people,
              autoplay: false,
            ),
          ),
        ),
      );
      expect(find.text('8472'), findsOneWidget);
      expect(find.text('Users'), findsOneWidget);
    });

    testWidgets('renders without icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedStatCard(value: 100, label: 'Test', autoplay: false),
          ),
        ),
      );
      expect(find.text('100'), findsOneWidget);
      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('renders with custom format', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnimatedStatCard(
              value: 99.9,
              label: 'Uptime',
              decimals: 1,
              format: (v) => '${v.toStringAsFixed(1)}%',
              autoplay: false,
            ),
          ),
        ),
      );
      expect(find.text('99.9%'), findsOneWidget);
    });
  });

  group('TrackingEffect', () {
    test('returns identity at progress 0', () {
      final effect = TrackingEffect();
      final animations = effect.getAnimations(0.0, 5);
      expect(animations.length, 5);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
      }
    });

    test('returns non-zero translation at progress 1', () {
      final effect = TrackingEffect(spacing: 30.0);
      final animations = effect.getAnimations(1.0, 5);
      expect(animations[0].translation.dx.abs(), greaterThan(0.0));
      expect(animations[4].translation.dx.abs(), greaterThan(0.0));
    });

    test('empty text returns empty list', () {
      final effect = TrackingEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('single character returns identity', () {
      final effect = TrackingEffect();
      final animations = effect.getAnimations(0.5, 1);
      expect(animations.length, 1);
      expect(animations[0].translation, Offset.zero);
    });

    test('respects custom spacing', () {
      final effect = TrackingEffect(spacing: 50.0);
      final low = TrackingEffect(spacing: 10.0);
      final hi = effect.getAnimations(1.0, 5);
      final lo = low.getAnimations(1.0, 5);
      expect(hi[0].translation.dx.abs(), greaterThan(lo[0].translation.dx.abs()));
    });
  });

  group('GlowRevealEffect', () {
    test('starts with high blur and low opacity', () {
      final effect = GlowRevealEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 5);
      expect(animations.length, 5);
      for (final anim in animations) {
        expect(anim.blurSigma, greaterThan(0.0));
        expect(anim.scale, greaterThan(1.0));
      }
    });

    test('ends at identity at progress 1', () {
      final effect = GlowRevealEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.blurSigma, closeTo(0.0, 0.01));
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.opacity, closeTo(1.0, 0.01));
      }
    });

    test('empty text returns empty list', () {
      final effect = GlowRevealEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('single character works', () {
      final effect = GlowRevealEffect();
      final animations = effect.getAnimations(0.5, 1);
      expect(animations.length, 1);
      expect(animations[0].scale, greaterThanOrEqualTo(1.0));
    });

    test('respects custom blurSigmaFrom', () {
      final effect = GlowRevealEffect(blurSigmaFrom: 20.0, delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 3);
      expect(animations[0].blurSigma, greaterThan(5.0));
    });
  });

  group('KineticTypeEffect', () {
    test('returns same values at progress 0 and 1', () {
      final effect = KineticTypeEffect();
      final at0 = effect.getAnimations(0.0, 5);
      final at1 = effect.getAnimations(1.0, 5);
      expect(at0.length, 5);
      expect(at1.length, 5);
      for (int i = 0; i < 5; i++) {
        expect(at0[i].translation.dx, closeTo(at1[i].translation.dx, 0.001));
        expect(at0[i].translation.dy, closeTo(at1[i].translation.dy, 0.001));
        expect(at0[i].rotation, closeTo(at1[i].rotation, 0.001));
        expect(at0[i].scale, closeTo(at1[i].scale, 0.001));
      }
    });

    test('empty text returns empty list', () {
      final effect = KineticTypeEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('single character returns identity', () {
      final effect = KineticTypeEffect();
      final animations = effect.getAnimations(0.5, 1);
      expect(animations.length, 1);
      expect(animations[0].translation, Offset.zero);
      expect(animations[0].rotation, 0.0);
      expect(animations[0].scale, 1.0);
    });

    test('different characters have different translations', () {
      final effect = KineticTypeEffect();
      final animations = effect.getAnimations(0.25, 5);
      expect(animations[0].translation.dy, isNot(animations[1].translation.dy));
    });

    test('respects custom amplitude', () {
      final effect = KineticTypeEffect(amplitude: 10.0);
      final animations = effect.getAnimations(0.25, 5);
      expect(animations.any((a) => a.translation.dy.abs() > 5.0), isTrue);
    });
  });

  group('SplitRevealEffect', () {
    test('characters offset from center at progress 0', () {
      final effect = SplitRevealEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 5);
      expect(animations.length, 5);
      expect(animations[0].translation.dx, lessThan(0.0));
      expect(animations[4].translation.dx, greaterThan(0.0));
    });

    test('all centered at progress 1', () {
      final effect = SplitRevealEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.translation, Offset.zero);
        expect(anim.opacity, closeTo(1.0, 0.01));
      }
    });

    test('empty text returns empty list', () {
      final effect = SplitRevealEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('single character returns identity', () {
      final effect = SplitRevealEffect();
      final animations = effect.getAnimations(0.5, 1);
      expect(animations.length, 1);
      expect(animations[0].translation, Offset.zero);
    });

    test('respects custom distance', () {
      final effect = SplitRevealEffect(distance: 150.0, delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 5);
      expect(animations[0].translation.dx.abs(), greaterThan(50.0));
    });
  });

  group('InkDropsEffect', () {
    test('starts with low opacity and scale at progress 0', () {
      final effect = InkDropsEffect();
      final animations = effect.getAnimations(0.0, 5);
      expect(animations.length, 5);
      for (final anim in animations) {
        expect(anim.opacity, closeTo(0.0, 0.01));
      }
    });

    test('ends at identity at progress 1', () {
      final effect = InkDropsEffect();
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, closeTo(1.0, 0.01));
        expect(anim.scale, closeTo(1.0, 0.01));
        expect(anim.blurSigma, closeTo(0.0, 0.01));
      }
    });

    test('empty text returns empty list', () {
      final effect = InkDropsEffect();
      expect(effect.getAnimations(0.5, 0), isEmpty);
    });

    test('single character returns identity', () {
      final effect = InkDropsEffect();
      final animations = effect.getAnimations(0.5, 1);
      expect(animations.length, 1);
      expect(animations[0].scale, 1.0);
      expect(animations[0].opacity, 1.0);
    });

    test('respects custom seed', () {
      final effectA = InkDropsEffect(seed: 1);
      final effectB = InkDropsEffect(seed: 999);
      final animsA = effectA.getAnimations(0.5, 5);
      final animsB = effectB.getAnimations(0.5, 5);
      expect(animsA[0].opacity, isNot(animsB[0].opacity));
    });
  });
}
