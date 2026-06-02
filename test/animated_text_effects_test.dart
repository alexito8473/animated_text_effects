import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

void main() {
  group('CharacterAnimation', () {
    test('default values', () {
      final anim = CharacterAnimation();
      expect(anim.opacity, 1.0);
      expect(anim.translation, Offset.zero);
      expect(anim.scale, 1.0);
      expect(anim.color, isNull);
      expect(anim.blurSigma, 0.0);
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

    test('combine uses last non-null color', () {
      final a = CharacterAnimation(color: Colors.red);
      final b = CharacterAnimation(color: Colors.blue);
      final c = a.combine(b);
      expect(c.color, Colors.blue);
    });

    test('combine sums blur sigma', () {
      final a = CharacterAnimation(blurSigma: 3.0);
      final b = CharacterAnimation(blurSigma: 2.0);
      final c = a.combine(b);
      expect(c.blurSigma, 5.0);
    });
  });

  group('FadeEffect', () {
    test('returns correct opacity for progress 0', () {
      final effect = FadeEffect(delayBetweenChars: Duration.zero);
      final animations = effect.getAnimations(0.0, 5);
      expect(animations.length, 5);
      expect(animations[0].opacity, closeTo(0.0, 0.01));
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
  });

  group('WaveEffect', () {
    test('returns scale values', () {
      final effect = WaveEffect();
      final animations = effect.getAnimations(0.0, 3);
      expect(animations.length, 3);
      for (final anim in animations) {
        expect(anim.scale, greaterThanOrEqualTo(0.5));
        expect(anim.scale, lessThanOrEqualTo(1.5));
      }
    });
  });

  group('TypewriterEffect', () {
    test('all invisible at progress 0', () {
      final effect = TypewriterEffect(delayBetweenChars: Duration(milliseconds: 100));
      final animations = effect.getAnimations(0.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, 0.0);
      }
    });

    test('all visible at progress 1', () {
      final effect = TypewriterEffect(delayBetweenChars: Duration(milliseconds: 100));
      final animations = effect.getAnimations(1.0, 5);
      for (final anim in animations) {
        expect(anim.opacity, 1.0);
      }
    });
  });

  group('BounceEffect', () {
    test('returns translation with negative dy', () {
      final effect = BounceEffect();
      final animations = effect.getAnimations(0.1, 3);
      for (final anim in animations) {
        expect(anim.translation.dy, lessThanOrEqualTo(0));
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
  });

  group('TextEffectController', () {
    test('default state', () {
      final controller = TextEffectController();
      expect(controller.isPlaying, false);
      expect(controller.isCompleted, false);
      expect(controller.progress, 0.0);
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
  });
}
