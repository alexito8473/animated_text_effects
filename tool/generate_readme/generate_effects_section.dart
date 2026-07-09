import 'dart:io';

class _Effect {
  final String displayName;
  final String className;
  final String gifName;

  const _Effect(this.displayName, this.className, this.gifName);
}

const _effects = [
  _Effect('Fade', 'FadeEffect', 'fade'),
  _Effect('Gradient', 'GradientEffect', 'gradient'),
  _Effect('Wave', 'WaveEffect', 'wave'),
  _Effect('Typewriter', 'TypewriterEffect', 'typewriter'),
  _Effect('Bounce', 'BounceEffect', 'bounce'),
  _Effect('Shimmer', 'ShimmerEffect', 'shimmer'),
  _Effect('Slide', 'SlideEffect', 'slide'),
  _Effect('Blur', 'BlurEffect', 'blur'),
  _Effect('Rainbow', 'RainbowEffect', 'rainbow'),
  _Effect('Glow', 'GlowEffect', 'glow'),
  _Effect('Ripple', 'RippleEffect', 'ripple'),
  _Effect('Spin', 'SpinEffect', 'spin'),
  _Effect('Flip', 'FlipEffect', 'flip'),
  _Effect('Wiggle', 'WiggleEffect', 'wiggle'),
  _Effect('Pulse', 'PulseEffect', 'pulse'),
  _Effect('Scatter', 'ScatterEffect', 'scatter'),
  _Effect('Neon Flicker', 'NeonFlickerEffect', 'neon_flicker'),
  _Effect('Elastic', 'ElasticEffect', 'elastic'),
  _Effect('Highlight', 'HighlightEffect', 'highlight'),
  _Effect('Underline', 'UnderlineEffect', 'underline'),
  _Effect('Progress Text', 'ProgressTextEffect', 'progress'),
  _Effect('Staggered Appear', 'StaggeredAppearEffect', 'staggered'),
  _Effect('Fire', 'FireEffect', 'fire'),
  _Effect('Smoke', 'SmokeEffect', 'smoke'),
  _Effect('VHS Glitch', 'VHSGlitchEffect', 'vhs_glitch'),
  _Effect('Reveal', 'RevealEffect', 'reveal'),
  _Effect('Liquid', 'LiquidEffect', 'liquid'),
  _Effect('Scanner', 'ScannerEffect', 'scanner'),
  _Effect('Wave Color', 'WaveColorEffect', 'wave_color'),
  _Effect('Breathing Opacity', 'BreathingOpacityEffect', 'breathing'),
  _Effect('Conveyor Belt', 'ConveyorBeltEffect', 'conveyor'),
  _Effect('Melt Drip', 'MeltDripEffect', 'melt_drip'),
  _Effect('Sparkle Twinkle', 'SparkleTwinkleEffect', 'sparkle'),
  _Effect('Matrix Rain', 'MatrixRainEffect', 'matrix'),
  _Effect('Glitch Split', 'GlitchSplitEffect', 'glitch_split'),
  _Effect('Scramble', 'ScrambleEffect', 'scramble'),
  _Effect('Pop In', 'PopInEffect', 'pop_in'),
  _Effect('Shake', 'ShakeEffect', 'shake'),
  _Effect('Flag Wave', 'FlagWaveEffect', 'flag_wave'),
  _Effect('Random Reveal', 'RandomRevealEffect', 'random_reveal'),
  _Effect('Tracking', 'TrackingEffect', 'tracking'),
  _Effect('Glow Reveal', 'GlowRevealEffect', 'glow_reveal'),
  _Effect('Kinetic Type', 'KineticTypeEffect', 'kinetic'),
  _Effect('Split Reveal', 'SplitRevealEffect', 'split_reveal'),
  _Effect('Ink Drops', 'InkDropsEffect', 'ink_drops'),
  _Effect('Chromatic Aberration', 'ChromaticAberrationEffect', 'chromatic_aberration'),
  _Effect('Pixelate', 'PixelateEffect', 'pixelate'),
  _Effect('Water Ripple', 'WaterRippleEffect', 'water_ripple'),
  _Effect('Vortex', 'VortexEffect', 'vortex'),
  _Effect('Cascade', 'CascadeEffect', 'cascade'),
  _Effect('Origami', 'OrigamiEffect', 'origami'),
  _Effect('Shatter', 'ShatterEffect', 'shatter'),
  _Effect('Morph', 'MorphEffect', 'morph'),
  _Effect('Curtain', 'CurtainEffect', 'curtain'),
  _Effect('Stomp', 'StompEffect', 'stomp'),
  _Effect('Typewriter Error', 'TypewriterErrorEffect', 'typewriter_error'),
  _Effect('Typewriter Delete', 'TypewriterDeleteEffect', 'typewriter_delete'),
  _Effect('Falling Leaves', 'FallingLeavesEffect', 'falling_leaves'),
  _Effect('Fireflies', 'FirefliesEffect', 'fireflies'),
  _Effect('Breath', 'BreathEffect', 'breath'),
  _Effect('Circular Reveal', 'CircularRevealEffect', 'circular_reveal'),
  _Effect('Scan Lines', 'ScanLinesEffect', 'scan_lines'),
  _Effect('Bar Wake', 'BarWakeEffect', 'bar_wake'),
  _Effect('Weight', 'WeightEffect', 'weight'),
  _Effect('Countdown', 'CountdownEffect', 'countdown'),
];

void main() {
  final buffer = StringBuffer();

  buffer.writeln('## \u{1F4CB} Effects');
  buffer.writeln();

  for (final e in _effects) {
    buffer.writeln('### ${e.displayName}');
    buffer.writeln();
    buffer.writeln('```dart');
    buffer.writeln("AnimatedText(");
    buffer.writeln("  'Hello World',");
    buffer.writeln("  effects: const [${e.className}()],");
    buffer.writeln("  style: TextStyle(fontSize: 32),");
    buffer.writeln(")");
    buffer.writeln('```');
    buffer.writeln();
    buffer.writeln('<p align="center">');
    buffer.writeln('  <img src="https://raw.githubusercontent.com/alexito8473/animated_text_effects/main/doc/screenshots/${e.gifName}.gif" width="600">');
    buffer.writeln('</p>');
    buffer.writeln();
    buffer.writeln('---');
    buffer.writeln();
  }

  buffer.writeln('## \u{1F517} Sequence & Rich Text');
  buffer.writeln();

  buffer.writeln('### AnimatedTextSequence');
  buffer.writeln();
  buffer.writeln('```dart');
  buffer.writeln('AnimatedTextSequence(');
  buffer.writeln("  texts: [");
  buffer.writeln("    SequenceText('Hello', effects: const [FadeEffect()]),");
  buffer.writeln("    SequenceText('World', effects: const [WaveEffect()]),");
  buffer.writeln("    SequenceText('!', effects: const [BounceEffect()]),");
  buffer.writeln("  ],");
  buffer.writeln("  repeat: true,");
  buffer.writeln("  displayDuration: Duration(seconds: 2),");
  buffer.writeln("  transitionDuration: Duration(milliseconds: 600),");
  buffer.writeln("  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),");
  buffer.writeln(")");
  buffer.writeln('```');
  buffer.writeln();
  buffer.writeln('<p align="center">');
  buffer.writeln('  <img src="https://raw.githubusercontent.com/alexito8473/animated_text_effects/main/doc/screenshots/sequence.gif" width="600">');
  buffer.writeln('</p>');
  buffer.writeln();
  buffer.writeln('---');
  buffer.writeln();

  buffer.writeln('### AnimatedRichText');
  buffer.writeln();
  buffer.writeln('```dart');
  buffer.writeln('AnimatedRichText(');
  buffer.writeln("  segments: [");
  buffer.writeln("    TextSegment.static('Static '),");
  buffer.writeln("    TextSegment.animated('Animated!', effects: const [FadeEffect(), WaveEffect()]),");
  buffer.writeln("    TextSegment.static(' suffix'),");
  buffer.writeln("  ],");
  buffer.writeln("  repeat: true,");
  buffer.writeln("  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),");
  buffer.writeln(")");
  buffer.writeln('```');
  buffer.writeln();
  buffer.writeln('<p align="center">');
  buffer.writeln('  <img src="https://raw.githubusercontent.com/alexito8473/animated_text_effects/main/doc/screenshots/rich_text.gif" width="600">');
  buffer.writeln('</p>');
  buffer.writeln();
  buffer.writeln('---');
  buffer.writeln();

  buffer.writeln('### AnimatedCounter');
  buffer.writeln();
  buffer.writeln('```dart');
  buffer.writeln('AnimatedCounter(');
  buffer.writeln("  value: 99999,");
  buffer.writeln("  duration: Duration(seconds: 3),");
  buffer.writeln("  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),");
  buffer.writeln(")");
  buffer.writeln('```');
  buffer.writeln();
  buffer.writeln('<p align="center">');
  buffer.writeln('  <img src="https://raw.githubusercontent.com/alexito8473/animated_text_effects/main/doc/screenshots/animated_counter.gif" width="600">');
  buffer.writeln('</p>');
  buffer.writeln();
  buffer.writeln('---');
  buffer.writeln();

  buffer.writeln('### AnimatedPercentage');
  buffer.writeln();
  buffer.writeln('```dart');
  buffer.writeln('AnimatedPercentage(');
  buffer.writeln("  value: 87.5,");
  buffer.writeln("  decimals: 1,");
  buffer.writeln("  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),");
  buffer.writeln(")");
  buffer.writeln('```');
  buffer.writeln();
  buffer.writeln('<p align="center">');
  buffer.writeln('  <img src="https://raw.githubusercontent.com/alexito8473/animated_text_effects/main/doc/screenshots/animated_percentage.gif" width="600">');
  buffer.writeln('</p>');
  buffer.writeln();
  buffer.writeln('---');
  buffer.writeln();

  buffer.writeln('### AnimatedCurrency');
  buffer.writeln();
  buffer.writeln('```dart');
  buffer.writeln('AnimatedCurrency(');
  buffer.writeln("  value: 123456.78,");
  buffer.writeln("  decimals: 2,");
  buffer.writeln("  symbol: r'\$',");
  buffer.writeln("  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),");
  buffer.writeln(")");
  buffer.writeln('```');
  buffer.writeln();
  buffer.writeln('<p align="center">');
  buffer.writeln('  <img src="https://raw.githubusercontent.com/alexito8473/animated_text_effects/main/doc/screenshots/animated_currency.gif" width="600">');
  buffer.writeln('</p>');
  buffer.writeln();
  buffer.writeln('---');
  buffer.writeln();

  buffer.writeln('### RollingDigitCounter');
  buffer.writeln();
  buffer.writeln('```dart');
  buffer.writeln('RollingDigitCounter(');
  buffer.writeln("  value: 2026,");
  buffer.writeln("  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),");
  buffer.writeln(")");
  buffer.writeln('```');
  buffer.writeln();
  buffer.writeln('<p align="center">');
  buffer.writeln('  <img src="https://raw.githubusercontent.com/alexito8473/animated_text_effects/main/doc/screenshots/rolling_digit.gif" width="600">');
  buffer.writeln('</p>');
  buffer.writeln();
  buffer.writeln('---');
  buffer.writeln();

  buffer.writeln('### AnimatedStatCard');
  buffer.writeln();
  buffer.writeln('```dart');
  buffer.writeln('AnimatedStatCard(');
  buffer.writeln("  value: 8472,");
  buffer.writeln("  label: 'Users',");
  buffer.writeln("  icon: Icons.people,");
  buffer.writeln("  activeColor: Colors.blue,");
  buffer.writeln(")");
  buffer.writeln('```');
  buffer.writeln();
  buffer.writeln('<p align="center">');
  buffer.writeln('  <img src="https://raw.githubusercontent.com/alexito8473/animated_text_effects/main/doc/screenshots/stat_card.gif" width="600">');
  buffer.writeln('</p>');
  buffer.writeln();
  buffer.writeln('---');
  buffer.writeln();

  buffer.writeln('## \u{1F680} Getting started');
  buffer.writeln();
  buffer.writeln('### Import');
  buffer.writeln();
  buffer.writeln('```dart');
  buffer.writeln("import 'package:animated_text_effects/animated_text_effects.dart';");
  buffer.writeln('```');
  buffer.writeln();
  buffer.writeln('---');

  stdout.write(buffer.toString());
}
