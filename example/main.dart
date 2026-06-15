/// animated_text_effects — Complete API Reference
///
/// Run the interactive Flutter demo:
///   cd example
///   flutter run
///
/// This file demonstrates the full public API surface:
/// - 40 composable text animation effects
/// - CharacterAnimation composition rules
/// - AnimatedText widget usage
/// - TextEffectController playback control
/// - 4 animated counter widgets
/// - Per-character override via `character` field

// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

void main() {
  print('=== animated_text_effects API Reference ===\n');

  // ═══════════════════════════════════════════════
  // 1. CREATING EFFECTS
  // ═══════════════════════════════════════════════

  print('--- 1. Creating Effects (40 available) ---\n');

  // Each effect extends TextEffect and implements getAnimations().
  // Parameters control duration, curve, staggering, and behavior.

  // -- 01. FadeEffect --
  final fade = FadeEffect(
    duration: Duration(milliseconds: 1000),
    curve: Curves.easeInOut,
    delayBetweenChars: Duration(milliseconds: 50),
    opacityFrom: 0.0,
    opacityTo: 1.0,
  );

  // -- 02. GradientEffect --
  final gradient = GradientEffect(
    duration: Duration(milliseconds: 2000),
    curve: Curves.linear,
    colors: const [Colors.blue, Colors.purple, Colors.pink],
    direction: Axis.horizontal,
  );

  // -- 03. WaveEffect --
  final wave = WaveEffect(
    duration: Duration(milliseconds: 1500),
    scaleMin: 0.5,
    scaleMax: 1.5,
    waveCount: 2,
  );

  // -- 04. TypewriterEffect --
  final typewriter = TypewriterEffect(
    duration: Duration(milliseconds: 1500),
    curve: Curves.linear,
    delayBetweenChars: Duration(milliseconds: 80),
    cursor: '|',
    cursorColor: Colors.amber,
  );

  // -- 05. BounceEffect --
  final bounce = BounceEffect(
    duration: Duration(milliseconds: 1000),
    curve: Curves.easeOut,
    height: 12.0,
    bounceCount: 1,
    delayBetweenChars: Duration(milliseconds: 60),
  );

  // -- 06. ShimmerEffect --
  final shimmer = ShimmerEffect(
    duration: Duration(milliseconds: 1500),
    baseColor: Colors.grey,
    highlightColor: Colors.white,
    width: 0.3,
  );

  // -- 07. SlideEffect --
  final slide = SlideEffect(
    duration: Duration(milliseconds: 800),
    curve: Curves.easeOut,
    delayBetweenChars: Duration(milliseconds: 30),
    direction: SlideDirection.left,
    distance: 50.0,
  );

  // -- 08. BlurEffect --
  final blur = BlurEffect(
    duration: Duration(milliseconds: 1000),
    curve: Curves.easeOut,
    delayBetweenChars: Duration(milliseconds: 40),
    sigmaFrom: 8.0,
    sigmaTo: 0.0,
  );

  // -- 09. RainbowEffect --
  final rainbow = RainbowEffect(
    duration: Duration(milliseconds: 2000),
    curve: Curves.linear,
    saturation: 0.8,
    lightness: 0.6,
    cycleCount: 1,
  );

  // -- 10. GlowEffect --
  final glow = GlowEffect(
    duration: Duration(milliseconds: 1500),
    blurMin: 3.0,
    blurMax: 12.0,
    opacityMin: 0.6,
    opacityMax: 1.0,
    glowColor: Colors.cyan,
  );

  // -- 11. RippleEffect --
  final ripple = RippleEffect(
    duration: Duration(milliseconds: 1200),
    curve: Curves.easeOut,
    scaleMin: 0.5,
    scaleMax: 1.3,
    height: 20.0,
    opacityMin: 0.0,
  );

  // -- 12. SpinEffect --
  final spin = SpinEffect(
    duration: Duration(milliseconds: 1000),
    curve: Curves.easeOut,
    spinCount: 1,
    scaleFrom: 0.0,
    delayBetweenChars: Duration(milliseconds: 60),
  );

  // -- 13. FlipEffect --
  final flip = FlipEffect(
    duration: Duration(milliseconds: 1000),
    curve: Curves.easeOut,
    flipCount: 1,
    delayBetweenChars: Duration(milliseconds: 80),
  );

  // -- 14. WiggleEffect --
  final wiggle = WiggleEffect(
    duration: Duration(milliseconds: 1000),
    amplitude: 4.0,
    frequency: 3.0,
    rotationAmplitude: 0.05,
  );

  // -- 15. PulseEffect --
  final pulse = PulseEffect(
    duration: Duration(milliseconds: 1000),
    scaleMin: 1.0,
    scaleMax: 1.3,
    opacityMin: 0.85,
  );

  // -- 16. ScatterEffect --
  final scatter = ScatterEffect(
    duration: Duration(milliseconds: 1000),
    curve: Curves.easeOut,
    distance: 150.0,
    delayBetweenChars: Duration(milliseconds: 30),
  );

  // -- 17. NeonFlickerEffect --
  final neon = NeonFlickerEffect(
    duration: Duration(milliseconds: 2000),
    curve: Curves.linear,
    baseColor: Colors.cyan,
    glowColor: Colors.cyan,
    blurSigma: 6.0,
    flickerSeed: 42,
  );

  // -- 18. ElasticEffect --
  final elastic = ElasticEffect(
    duration: Duration(milliseconds: 800),
    curve: Curves.elasticOut,
    stretch: 0.3,
    bounceCount: 1,
    delayBetweenChars: Duration(milliseconds: 60),
  );

  // -- 19. HighlightEffect --
  final highlight = HighlightEffect(
    duration: Duration(milliseconds: 800),
    curve: Curves.easeInOut,
    highlightColor: Colors.yellow,
    opacityFrom: 0.0,
    opacityTo: 0.6,
    delayBetweenChars: Duration(milliseconds: 40),
  );

  // -- 20. UnderlineEffect --
  final underline = UnderlineEffect(
    duration: Duration(milliseconds: 600),
    curve: Curves.easeOut,
    lineColor: Colors.blue,
    height: 2.0,
    delayBetweenChars: Duration(milliseconds: 30),
  );

  // -- 21. ProgressTextEffect --
  final progressText = ProgressTextEffect(
    duration: Duration(milliseconds: 1000),
    curve: Curves.easeOut,
    filledColor: Colors.green,
    emptyColor: Colors.grey,
  );

  // -- 22. StaggeredAppearEffect --
  final staggered = StaggeredAppearEffect(
    duration: Duration(milliseconds: 800),
    curve: Curves.easeOut,
    delayBetweenChars: Duration(milliseconds: 40),
    direction: SlideDirection.down,
    distance: 30.0,
    opacityFrom: 0.0,
  );

  // -- 23. FireEffect --
  final fire = FireEffect(
    duration: Duration(milliseconds: 1500),
    curve: Curves.linear,
    jitter: 3.0,
    blurSigma: 4.0,
    maxScale: 1.15,
  );

  // -- 24. SmokeEffect --
  final smoke = SmokeEffect(
    duration: Duration(milliseconds: 1200),
    curve: Curves.easeOut,
    height: 40.0,
    blurSigma: 6.0,
    delayBetweenChars: Duration(milliseconds: 50),
  );

  // -- 25. VHSGlitchEffect --
  final vhs = VHSGlitchEffect(
    duration: Duration(milliseconds: 2000),
    curve: Curves.linear,
    jitter: 8.0,
    colorOffset: 4.0,
    maxBlur: 1.5,
  );

  // -- 26. RevealEffect --
  final reveal = RevealEffect(
    duration: Duration(milliseconds: 800),
    curve: Curves.easeOut,
    clipFrom: 0.0,
    delayBetweenChars: Duration(milliseconds: 30),
  );

  // -- 27. LiquidEffect --
  final liquid = LiquidEffect(
    duration: Duration(milliseconds: 1500),
    amplitude: 0.3,
    frequency: 2.0,
    waveHeight: 6.0,
  );

  // -- 28. ScannerEffect --
  final scanner = ScannerEffect(
    duration: Duration(milliseconds: 1200),
    curve: Curves.easeInOut,
    scanColor: Colors.cyan,
    scanWidth: 0.15,
    glowWidth: 0.3,
  );

  // -- 29. WaveColorEffect --
  final waveColor = WaveColorEffect(
    duration: Duration(milliseconds: 1500),
    colorA: Colors.blue,
    colorB: Colors.purple,
    waveCount: 2,
  );

  // -- 30. BreathingOpacityEffect --
  final breath = BreathingOpacityEffect(
    duration: Duration(milliseconds: 2000),
    opacityMin: 0.7,
  );

  // -- 31. ConveyorBeltEffect --
  final conveyor = ConveyorBeltEffect(
    duration: Duration(milliseconds: 2000),
    spacing: 30.0,
    reverse: false,
  );

  // -- 32. MeltDripEffect --
  final melt = MeltDripEffect(
    duration: Duration(milliseconds: 1500),
    curve: Curves.easeIn,
    meltAmount: 0.5,
    dripHeight: 40.0,
    blurSigma: 3.0,
    delayBetweenChars: Duration(milliseconds: 30),
  );

  // -- 33. SparkleTwinkleEffect --
  final sparkle = SparkleTwinkleEffect(
    duration: Duration(milliseconds: 2500),
    sparkleColor: Colors.amber,
    sparkleScale: 1.4,
    sparkleBlur: 4.0,
  );

  // -- 34. MatrixRainEffect --
  final matrix = MatrixRainEffect(
    duration: Duration(milliseconds: 2000),
    curve: Curves.linear,
    matrixGreen: Colors.green,
    fallSpeed: 1.0,
    blurSigma: 2.0,
  );

  // -- 35. GlitchSplitEffect --
  final glitchSplit = GlitchSplitEffect(
    duration: Duration(milliseconds: 1500),
    curve: Curves.linear,
    splitAmount: 4.0,
    probability: 0.3,
  );

  // -- 36. ScrambleEffect --
  final scramble = ScrambleEffect(
    duration: Duration(milliseconds: 2000),
    curve: Curves.easeOut,
    delayBetweenChars: Duration(milliseconds: 30),
    seed: 42,
    charset: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',
  );

  // -- 37. PopInEffect --
  final popIn = PopInEffect(
    duration: Duration(milliseconds: 600),
    curve: Curves.easeOut,
    delayBetweenChars: Duration(milliseconds: 40),
    scalePeak: 1.3,
  );

  // -- 38. ShakeEffect --
  final shake = ShakeEffect(
    duration: Duration(milliseconds: 800),
    curve: Curves.easeOut,
    intensity: 6.0,
    frequency: 4.0,
  );

  // -- 39. FlagWaveEffect --
  final flagWave = FlagWaveEffect(
    duration: Duration(milliseconds: 1500),
    amplitude: 0.4,
    waveCount: 2,
  );

  // -- 40. RandomRevealEffect --
  final randomReveal = RandomRevealEffect(
    duration: Duration(milliseconds: 1200),
    curve: Curves.easeOut,
    seed: 42,
    opacityFrom: 0.0,
  );

  print('All 40 effects created successfully.\n');

  // ═══════════════════════════════════════════════
  // 2. GETTING ANIMATIONS
  // ═══════════════════════════════════════════════

  print('--- 2. Getting Per-Character Animations ---\n');

  final anims = fade.getAnimations(0.5, 6);
  for (int i = 0; i < anims.length; i++) {
    print('  Char $i: opacity=${anims[i].opacity}, '
        'scale=${anims[i].scale}, '
        'translation=${anims[i].translation}');
  }

  // staggeredProgress computes individual character timing
  final charProgress = fade.staggeredProgress(0.5, 2, 6);
  print('  Staggered progress for char 2 at global 0.5: $charProgress');
  print('');

  // Noise helper — deterministic per-character values
  final a = fade.noise(0);
  final b = fade.noise(1);
  final c = fade.noise(2);
  print('  Noise values: a=$a, b=$b, c=$c (reproducible across runs)\n');

  // ═══════════════════════════════════════════════
  // 3. EFFECT COMPOSITION
  // ═══════════════════════════════════════════════

  print('--- 3. Effect Composition Rules ---\n');

  // Combine multiple effects via CharacterAnimation.combine().
  // AnimatedText does this internally for all registered effects.

  final f = FadeEffect(delayBetweenChars: Duration.zero);
  final s = SlideEffect(
    delayBetweenChars: Duration.zero,
    distance: 20.0,
  );
  final fadeChars = f.getAnimations(0.5, 5);
  final slideChars = s.getAnimations(0.5, 5);

  // Compose character by character
  for (int i = 0; i < 5; i++) {
    final combined = fadeChars[i].combine(slideChars[i]);
    print('  Char $i: '
        'opacity=${combined.opacity} '
        '(fade=${fadeChars[i].opacity} × slide=${slideChars[i].opacity}), '
        'translation=${combined.translation} '
        '(slide=${slideChars[i].translation})');
  }
  print('');

  // Composition rules summary:
  //   opacity         → MULTIPLIED
  //   scale/scaleX/Y  → MULTIPLIED
  //   clipProgress    → MULTIPLIED
  //   translation     → SUMMED
  //   blurSigma       → SUMMED
  //   rotation/X/Y    → SUMMED
  //   underlineProg.  → SUMMED
  //   color           → LAST NON-NULL
  //   backgroundColor → LAST NON-NULL
  //   character       → LAST NON-NULL

  // ═══════════════════════════════════════════════
  // 4. CHARACTERANIMATION PROPERTIES
  // ═══════════════════════════════════════════════

  print('--- 4. CharacterAnimation Properties ---\n');

  const identity = CharacterAnimation();
  print('  Identity: opacity=${identity.opacity}, '
      'scale=${identity.scale}, '
      'translation=${identity.translation}');

  final custom = CharacterAnimation(
    opacity: 0.5,
    scale: 1.2,
    color: Colors.red,
    translation: Offset(10, 0),
    rotation: 0.5,
    blurSigma: 2.0,
    clipProgress: 0.8,
    character: 'A',
  );
  print('  Custom: opacity=${custom.opacity}, '
      'scale=${custom.scale}, '
      'color=${custom.color}, '
      'character=${custom.character}\n');

  // ═══════════════════════════════════════════════
  // 5. WIDGET USAGE (reference — requires Flutter)
  // ═══════════════════════════════════════════════

  print('--- 5. AnimatedText Widget (Flutter) ---\n');

  print('''
  // Single effect:
  AnimatedText(
    'Hello World',
    effects: const [FadeEffect()],
    style: TextStyle(fontSize: 32),
  )

  // Multiple combined effects:
  AnimatedText(
    'Fade + Wave + Gradient',
    effects: const [
      FadeEffect(delayBetweenChars: Duration(milliseconds: 30)),
      WaveEffect(scaleMin: 0.8, scaleMax: 1.2),
      GradientEffect(colors: [Colors.cyan, Colors.purple, Colors.orange]),
    ],
    repeat: true,
  )

  // Full control:
  AnimatedText(
    'Styled + Loop',
    effects: const [WaveEffect(), GlowEffect()],
    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    repeat: true,
    reverse: true,
    textAlign: TextAlign.center,
    autoplay: true,
    keepAlive: true,
  )
  ''');

  // ═══════════════════════════════════════════════
  // 6. TextEffectController
  // ═══════════════════════════════════════════════

  print('--- 6. TextEffectController ---\n');

  print('''
  // Create a shared controller:
  final controller = TextEffectController();

  // Pass to one or more AnimatedText widgets:
  AnimatedText('A', effects: const [FadeEffect()], controller: controller);
  AnimatedText('B', effects: const [WaveEffect()], controller: controller);

  // Control all simultaneously:
  controller.play();
  controller.pause();
  controller.stop();
  controller.repeat();
  controller.repeat(reverse: true);
  controller.repeat(count: 3);
  controller.seekTo(0.5);

  // Controller saves progress on detach, restores on attach:
  controller.dispose();  // saves current progress
  ''');

  // ═══════════════════════════════════════════════
  // 7. ANIMATED COUNTER WIDGETS
  // ═══════════════════════════════════════════════

  print('--- 7. Animated Counter Widgets ---\n');

  print(r'''
  // AnimatedCounter — generic animated number
  AnimatedCounter(
    value: 42,
    decimals: 1,
    duration: Duration(milliseconds: 1000),
    curve: Curves.easeOut,
    activeColor: Colors.blue,
    scalePulse: true,
    format: (v) => v.toStringAsFixed(1),
  )

  // AnimatedPercentage — with % suffix
  AnimatedPercentage(
    value: 75.5,
    decimals: 1,
    showPercentSign: true,
  )

  // AnimatedCurrency — with symbol and formatting
  AnimatedCurrency(
    value: 1234.56,
    symbol: r'$',
    decimals: 2,
    showPlusSign: true,
  )

  // AnimatedStatCard — card with icon, label, and animated value
  AnimatedStatCard(
    value: 15000,
    label: 'Followers',
    icon: Icons.people,
    decimals: 0,
    activeColor: Colors.blue,
    elevation: 2,
  )

  // RollingDigitCounter — digit-box style
  RollingDigitCounter(
    value: 42,
    digitWidth: 28,
    digitHeight: 40,
    backgroundColor: Colors.grey[200],
  )
  ''');

  // ═══════════════════════════════════════════════
  // 8. EFFECT CONTRACT
  // ═══════════════════════════════════════════════

  print('--- 8. Effect Contract: f(0) == f(1) ---\n');

  // Every effect guarantees identical output at progress 0 and progress 1.
  final contract = FadeEffect(delayBetweenChars: Duration.zero);
  final p0 = contract.getAnimations(0.0, 5);
  final p1 = contract.getAnimations(1.0, 5);
  for (int i = 0; i < 5; i++) {
    assert(p0[i].opacity == p1[i].opacity);
    assert(p0[i].scale == p1[i].scale);
    assert(p0[i].translation == p1[i].translation);
  }
  print('  f(0) == f(1): all characters return to identity state.\n');

  // ═══════════════════════════════════════════════
  // 9. CHARACTER OVERRIDE
  // ═══════════════════════════════════════════════

  print('--- 9. Per-Character Text Override ---\n');

  // ScrambleEffect replaces characters during animation:
  final scram = ScrambleEffect(delayBetweenChars: Duration.zero, seed: 42);
  final scrambled = scram.getAnimations(0.0, 6);
  for (int i = 0; i < scrambled.length; i++) {
    print('  Char $i overridden to: ${scrambled[i].character}');
  }
  // At progress 1, character returns to null (original text is used)
  final resolved = scram.getAnimations(1.0, 6);
  print('  At progress 1: all characters are null = '
      '${resolved.every((a) => a.character == null)}');
  print('');

  // ═══════════════════════════════════════════════
  // 10. TIMING & STAGGERING
  // ═══════════════════════════════════════════════

  print('--- 10. Timing & Staggering ---\n');

  final staggeredEffect = FadeEffect(
    delayBetweenChars: Duration(milliseconds: 100),
    duration: Duration(milliseconds: 500),
  );
  final totalDuration = staggeredEffect.getTotalDuration(10);
  print('  Effect duration: 500ms');
  print('  Delay per char: 100ms');
  print('  Total for 10 chars: ${totalDuration.inMilliseconds}ms');

  final timings = staggeredEffect.getAnimations(0.3, 5);
  print('  At progress 0.3, opacities: '
      '${timings.map((a) => a.opacity.toStringAsFixed(2)).join(', ')}');
  print('');

  // ═══════════════════════════════════════════════
  // 11. LOOPING
  // ═══════════════════════════════════════════════

  print('--- 11. Looping Modes ---\n');

  print('''
  // Forward loop:
  AnimatedText('Text', effects: const [WaveEffect()], repeat: true);

  // Ping-pong (forward then reverse):
  AnimatedText('Text', effects: const [BounceEffect()], repeat: true, reverse: true);

  // One-shot (default):
  AnimatedText('Text', effects: const [FadeEffect()], autoplay: true, repeat: false);
  ''');

  // ═══════════════════════════════════════════════
  // 12. SCROLL PERSISTENCE
  // ═══════════════════════════════════════════════

  print('--- 12. Scroll Persistence ---\n');

  print('''
  // Animations survive scrolling off-screen by default:
  AnimatedText('Stays alive', effects: const [FadeEffect()], keepAlive: true);

  // Use TextEffectController for cross-mount/unmount persistence:
  //   controller saves progress on detach
  //   controller.restores progress on attach
  ''');

  print('=== End API Reference ===');
}
