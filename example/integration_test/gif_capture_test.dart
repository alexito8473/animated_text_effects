import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

class _Scenario {
  final String name;
  final String text;
  final List<TextEffect> effects;
  final int frames;
  final int totalMs;
  final bool repeat;
  final Widget? customWidget;
  final int holdFrames;

  const _Scenario({
    required this.name,
    required this.text,
    required this.effects,
    this.frames = 40,
    this.totalMs = 4000,
    this.repeat = true,
    this.customWidget,
    this.holdFrames = 0,
  });

  Duration get durationPerFrame =>
      Duration(milliseconds: totalMs ~/ frames);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final allScenarios = <_Scenario>[
    // ═══════════════════════════════════════════════════
    // 45 EFECTOS INDIVIDUALES (repeat)
    // ═══════════════════════════════════════════════════
    _Scenario(name: 'fade', text: 'FADE', effects: const [FadeEffect()], holdFrames: 0),
    _Scenario(name: 'gradient', text: 'GRADIENT', effects: const [GradientEffect()], holdFrames: 0),
    _Scenario(name: 'wave', text: 'WAVE', effects: const [WaveEffect()], holdFrames: 0),
    _Scenario(name: 'typewriter', text: 'TYPEWRITER', effects: const [TypewriterEffect()], holdFrames: 6),
    _Scenario(name: 'bounce', text: 'BOUNCE', effects: const [BounceEffect()], holdFrames: 0),
    _Scenario(name: 'shimmer', text: 'SHIMMER', effects: const [ShimmerEffect()], holdFrames: 0),
    _Scenario(name: 'slide', text: 'SLIDE', effects: const [SlideEffect()], holdFrames: 4),
    _Scenario(name: 'blur', text: 'BLUR', effects: const [BlurEffect()], holdFrames: 6),
    _Scenario(name: 'rainbow', text: 'RAINBOW', effects: const [RainbowEffect()], holdFrames: 0),
    _Scenario(name: 'glow', text: 'GLOW', effects: const [GlowEffect()], holdFrames: 0),
    _Scenario(name: 'ripple', text: 'RIPPLE', effects: const [RippleEffect()], holdFrames: 6),
    _Scenario(name: 'spin', text: 'SPIN', effects: const [SpinEffect()], holdFrames: 0),
    _Scenario(name: 'flip', text: 'FLIP', effects: const [FlipEffect()], holdFrames: 4),
    _Scenario(name: 'wiggle', text: 'WIGGLE', effects: const [WiggleEffect()], holdFrames: 0),
    _Scenario(name: 'pulse', text: 'PULSE', effects: const [PulseEffect()], holdFrames: 0),
    _Scenario(name: 'scatter', text: 'SCATTER', effects: const [ScatterEffect()], holdFrames: 6),
    _Scenario(name: 'neon_flicker', text: 'NEON', effects: const [NeonFlickerEffect(glowColor: Colors.pinkAccent, blurSigma: 3.0)], holdFrames: 0),
    _Scenario(name: 'elastic', text: 'ELASTIC', effects: const [ElasticEffect()], holdFrames: 4),
    _Scenario(name: 'highlight', text: 'HIGHLIGHT', effects: const [HighlightEffect()], holdFrames: 4),
    _Scenario(name: 'underline', text: 'UNDERLINE', effects: const [UnderlineEffect(lineColor: Colors.cyan, height: 4.0)], holdFrames: 8),
    _Scenario(name: 'progress', text: 'PROGRESS', effects: const [ProgressTextEffect()], holdFrames: 4),
    _Scenario(name: 'staggered', text: 'STAGGERED', effects: const [StaggeredAppearEffect()], holdFrames: 6),
    _Scenario(name: 'fire', text: 'FIRE', effects: const [FireEffect(jitter: 8.0, blurSigma: 2.0, maxScale: 1.3)], holdFrames: 0),
    _Scenario(name: 'smoke', text: 'SMOKE', effects: const [SmokeEffect(height: 80.0, blurSigma: 3.0)], holdFrames: 6),
    _Scenario(name: 'vhs_glitch', text: 'GLITCH', effects: const [VHSGlitchEffect()], holdFrames: 0),
    _Scenario(name: 'reveal', text: 'REVEAL', effects: const [RevealEffect()], holdFrames: 4),
    _Scenario(name: 'liquid', text: 'LIQUID', effects: const [LiquidEffect()], holdFrames: 0),
    _Scenario(name: 'scanner', text: 'SCANNER', effects: const [ScannerEffect()], holdFrames: 4),
    _Scenario(name: 'wave_color', text: 'WAVE COLOR', effects: const [WaveColorEffect()], holdFrames: 0),
    _Scenario(name: 'breathing', text: 'BREATHING', effects: const [BreathingOpacityEffect()], holdFrames: 0),
    _Scenario(name: 'conveyor', text: 'CONVEYOR', effects: const [ConveyorBeltEffect()], holdFrames: 0),
    _Scenario(name: 'melt_drip', text: 'MELT', effects: const [MeltDripEffect()], holdFrames: 6),
    _Scenario(name: 'sparkle', text: 'SPARKLE', effects: const [SparkleTwinkleEffect()], holdFrames: 0),
    _Scenario(name: 'matrix', text: 'MATRIX RAIN', effects: const [MatrixRainEffect()], holdFrames: 0),
    _Scenario(name: 'glitch_split', text: 'RGB SPLIT', effects: const [GlitchSplitEffect()], holdFrames: 0),
    _Scenario(name: 'scramble', text: 'SCRAMBLE', effects: const [ScrambleEffect()], holdFrames: 6),
    _Scenario(name: 'pop_in', text: 'POP IN!', effects: const [PopInEffect()], holdFrames: 6),
    _Scenario(name: 'shake', text: 'SHAKE', effects: const [ShakeEffect()], holdFrames: 0),
    _Scenario(name: 'flag_wave', text: 'FLAG WAVE', effects: const [FlagWaveEffect()], holdFrames: 0),
    _Scenario(name: 'random_reveal', text: 'RANDOM', effects: const [RandomRevealEffect()], holdFrames: 6),
    _Scenario(name: 'tracking', text: 'TRACKING', effects: const [TrackingEffect()], holdFrames: 0),
    _Scenario(name: 'glow_reveal', text: 'GLOW', effects: const [GlowRevealEffect()], holdFrames: 6),
    _Scenario(name: 'kinetic', text: 'KINETIC', effects: const [KineticTypeEffect()], holdFrames: 0),
    _Scenario(name: 'split_reveal', text: 'SPLIT', effects: const [SplitRevealEffect()], holdFrames: 6),
    _Scenario(name: 'ink_drops', text: 'INK', effects: const [InkDropsEffect()], holdFrames: 6),

    // ═══════════════════════════════════════════════════
    // DEMO COMBINADO (hero)
    // ═══════════════════════════════════════════════════
    _Scenario(
      name: 'combo',
      text: 'FADE + WAVE + GRADIENT',
      effects: const [
        FadeEffect(delayBetweenChars: Duration(milliseconds: 30)),
        WaveEffect(scaleMin: 0.8, scaleMax: 1.2),
        GradientEffect(colors: [Colors.cyan, Colors.purple, Colors.orange]),
      ],
      totalMs: 3000, frames: 30, holdFrames: 0,
    ),

    // ═══════════════════════════════════════════════════
    // ANIMATED RICH TEXT
    // ═══════════════════════════════════════════════════
    _Scenario(
      name: 'rich_text',
      text: 'rich_text',
      effects: const [],
      frames: 24, totalMs: 2400, holdFrames: 4,
      customWidget: AnimatedRichText(
        segments: [
          const TextSegment.static('Static '),
          TextSegment.animated('Animated!', effects: const [FadeEffect(), WaveEffect()]),
          const TextSegment.static(' suffix'),
        ],
        repeat: true,
        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),

    // ═══════════════════════════════════════════════════
    // ANIMATED TEXT SEQUENCE
    // ═══════════════════════════════════════════════════
    _Scenario(
      name: 'sequence',
      text: 'sequence',
      effects: const [],
      frames: 30, totalMs: 7600, holdFrames: 0,
      customWidget: AnimatedTextSequence(
        texts: [
          SequenceText('Hello', effects: const [FadeEffect()]),
          SequenceText('World', effects: const [WaveEffect()]),
          const SequenceText('!', effects: [BounceEffect()]),
        ],
        repeat: true,
        displayDuration: const Duration(seconds: 2),
        transitionDuration: const Duration(milliseconds: 600),
        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),

    // ═══════════════════════════════════════════════════
    // COUNTERS
    // ═══════════════════════════════════════════════════
    _Scenario(
      name: 'animated_counter',
      text: '',
      effects: const [],
      frames: 30, totalMs: 3000, holdFrames: 8,
      customWidget: AnimatedCounter(
        value: 99999,
        duration: const Duration(seconds: 3),
        style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.greenAccent),
        autoplay: true,
      ),
    ),
    _Scenario(
      name: 'animated_percentage',
      text: '',
      effects: const [],
      frames: 30, totalMs: 3000, holdFrames: 8,
      customWidget: AnimatedPercentage(
        value: 87.5,
        decimals: 1,
        duration: const Duration(seconds: 3),
        style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
        autoplay: true,
      ),
    ),
    _Scenario(
      name: 'animated_currency',
      text: '',
      effects: const [],
      frames: 30, totalMs: 3000, holdFrames: 8,
      customWidget: AnimatedCurrency(
        value: 123456.78,
        decimals: 2,
        symbol: r'$',
        duration: const Duration(seconds: 3),
        style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.amberAccent),
        autoplay: true,
      ),
    ),
    _Scenario(
      name: 'rolling_digit',
      text: '',
      effects: const [],
      frames: 30, totalMs: 3000, holdFrames: 8,
      customWidget: RollingDigitCounter(
        value: 2026,
        duration: const Duration(seconds: 3),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
        digitWidth: 30,
        digitHeight: 50,
        autoplay: true,
      ),
    ),
    _Scenario(
      name: 'stat_card',
      text: '',
      effects: const [],
      frames: 30, totalMs: 3000, holdFrames: 8,
      customWidget: AnimatedStatCard(
        value: 8472,
        label: 'Users',
        icon: Icons.people,
        activeColor: Colors.blue,
        duration: const Duration(seconds: 3),
        valueStyle: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
        labelStyle: const TextStyle(fontSize: 18, color: Colors.grey),
        autoplay: true,
      ),
    ),
  ];

  for (final scenario in allScenarios) {
    testWidgets('capture_${scenario.name}', (tester) async {
      final key = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: RepaintBoundary(
                key: key,
                child: Container(
                  width: 800,
                  height: 300,
                  color: Colors.black,
                  child: Center(
                    child: scenario.customWidget ??
                        AnimatedText(
                          scenario.text,
                          effects: scenario.effects,
                          repeat: scenario.repeat,
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      final dir = Directory(scenario.name);
      if (dir.existsSync()) {
        dir.deleteSync(recursive: true);
      }
      dir.createSync(recursive: true);

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      final boundary = key.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) {
        throw Exception('RepaintBoundary not found');
      }

      final totalFrames = scenario.frames + scenario.holdFrames;
      for (int i = 0; i < totalFrames; i++) {
        if (i < scenario.frames) {
          await tester.pump(scenario.durationPerFrame);
        } else {
          await tester.pump(const Duration(milliseconds: 100));
        }

        final image = await boundary.toImage(pixelRatio: 2.0);
        final byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData == null) continue;

        final file = File(
          '${dir.path}/frame_${i.toString().padLeft(3, '0')}.png',
        );
        await file.writeAsBytes(byteData.buffer.asUint8List());
      }

      print('Captured ${totalFrames} frames for ${scenario.name}');
    });
  }
}
