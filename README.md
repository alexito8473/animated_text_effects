# animated_text_effects

A Flutter package for text with **45 composable animation effects** and **4 animated counter widgets**. Combine effects freely, control playback, and persist state across scroll off-screen.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.3%2B-blue" alt="Flutter">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License">
  <img src="https://img.shields.io/badge/version-0.0.1-orange" alt="Version">
</p>

---

## ✨ Features

- **45 effects** — fade, wave, typewriter, fire, smoke, matrix rain, glitch, scramble, shake, tracking, glow reveal, kinetic type, split reveal, ink drops, and more
- **Composable** — apply multiple effects simultaneously (opacity multiplies, translation sums, last color wins)
- **Loop modes** — forward, ping-pong, or finite repeat counts
- **External controller** — `TextEffectController` for play/pause/stop/seek
- **Scroll persistence** — animations survive scrolling off-screen via `keepAlive` (default `true`)
- **Counter widgets** — `AnimatedCounter`, `AnimatedPercentage`, `AnimatedCurrency`, `AnimatedStatCard`, `RollingDigitCounter`
- **Sequence widgets** — `AnimatedTextSequence` for sequential multi-text playback, `AnimatedRichText` for mixing static & animated text inline
- **Interactive demos** — included in example app with real-time parameter controls

## 📋 Effects

| # | Effect | Widget | Description |
|---|---|---|---|
| 1 | **Fade** | `FadeEffect` | Characters fade in sequentially |
| 2 | **Gradient** | `GradientEffect` | Animated color sweep across text |
| 3 | **Wave** | `WaveEffect` | Characters scale up/down in a wave |
| 4 | **Typewriter** | `TypewriterEffect` | Classic typewriter reveal with cursor |
| 5 | **Bounce** | `BounceEffect` | Characters bounce vertically in sequence |
| 6 | **Shimmer** | `ShimmerEffect` | Highlight sweep across the text |
| 7 | **Slide** | `SlideEffect` | Characters slide in from any direction |
| 8 | **Blur** | `BlurEffect` | Characters transition blurry-to-sharp |
| 9 | **Rainbow** | `RainbowEffect` | Cycling rainbow colors per character |
| 10 | **Glow** | `GlowEffect` | Pulsing glow behind text |
| 11 | **Ripple** | `RippleEffect` | Circular ripple from center outward |
| 12 | **Spin** | `SpinEffect` | Characters rotate around their center |
| 13 | **Flip** | `FlipEffect` | Characters flip horizontally |
| 14 | **Wiggle** | `WiggleEffect` | Random-angle jitter per character |
| 15 | **Pulse** | `PulseEffect` | Scale pulsing rhythm |
| 16 | **Scatter** | `ScatterEffect` | Characters fly in from random offsets |
| 17 | **Neon Flicker** | `NeonFlickerEffect` | Random flicker with glow color |
| 18 | **Elastic** | `ElasticEffect` | Overshoot bounce with elastic curve |
| 19 | **Highlight** | `HighlightEffect` | Background color highlight sweep |
| 20 | **Underline** | `UnderlineEffect` | Animated underline per character |
| 21 | **Progress Text** | `ProgressTextEffect` | Binary color switch left-to-right |
| 22 | **Staggered Appear** | `StaggeredAppearEffect` | Sequential slide+opacity from any direction |
| 23 | **Fire** | `FireEffect` | Flickering orange/red/yellow flames |
| 24 | **Smoke** | `SmokeEffect` | Rising smoky particles that fade |
| 25 | **VHS Glitch** | `VHSGlitchEffect` | Scan lines + color shift + jitter |
| 26 | **Reveal** | `RevealEffect` | Clip-reveal from top/bottom/left/right |
| 27 | **Liquid** | `LiquidEffect` | Wavy distortion + gradient swoosh |
| 28 | **Scanner** | `ScannerEffect` | Scanning line reveal with clip |
| 29 | **Wave Color** | `WaveColorEffect` | Color wave across characters |
| 30 | **Breathing Opacity** | `BreathingOpacityEffect` | Slow pulsing opacity |
| 31 | **Conveyor Belt** | `ConveyorBeltEffect` | Characters loop horizontally |
| 32 | **Melt Drip** | `MeltDripEffect` | Stretch + slide down like melting |
| 33 | **Sparkle Twinkle** | `SparkleTwinkleEffect` | Random sparkle highlights |
| 34 | **Matrix Rain** | `MatrixRainEffect` | Green rain characters falling |
| 35 | **Glitch Split** | `GlitchSplitEffect` | Horizontal split with offset jitter |
| 36 | **Scramble** | `ScrambleEffect` | Characters unscramble from random chars via `character` override |
| 37 | **Pop In** | `PopInEffect` | Scale overshoot entrance (peak > 1.0, settles at 1.0) |
| 38 | **Shake** | `ShakeEffect` | Earthquake-style jitter with decreasing intensity |
| 39 | **Flag Wave** | `FlagWaveEffect` | 3D rotationY sinusoidal wave (like a waving flag) |
| 40 | **Random Reveal** | `RandomRevealEffect` | Characters reveal in random order via noise threshold |
| 41 | **Tracking** | `TrackingEffect` | Letter-spacing expansion from center or rightward |
| 42 | **Glow Reveal** | `GlowRevealEffect` | Cinematic bloom-to-sharp (blur + scale + opacity) |
| 43 | **Kinetic Type** | `KineticTypeEffect` | Continuous wave bob/floating (Apple keynote style) |
| 44 | **Split Reveal** | `SplitRevealEffect` | Characters split from center (left half from left, right from right) |
| 45 | **Ink Drops** | `InkDropsEffect` | Ink splatter reveal outward from random drop points |

## 📟 Counter Widgets

| Widget | Description |
|---|---|
| `AnimatedCounter` | Generic animated number (int or double) with color lerp and scale pulse |
| `AnimatedPercentage` | `AnimatedCounter` with `%` suffix |
| `AnimatedCurrency` | `AnimatedCounter` with symbol, thousands separator, plus sign |
| `AnimatedStatCard` | Material card with icon, label, and `AnimatedCounter` |
| `RollingDigitCounter` | Digit-box style counter with per-character boxes |

## 📦 Sequence widgets

### AnimatedTextSequence — sequential multi-text playback

Cycle through a list of texts with individual effects, transition animations, and configurable display/transition durations.

```dart
AnimatedTextSequence(
  texts: [
    SequenceText('Hello', effects: const [FadeEffect()]),
    SequenceText('World', effects: const [WaveEffect()]),
    SequenceText('!', effects: const [BounceEffect()]),
  ],
  repeat: true,
  displayDuration: Duration(seconds: 3),
  transitionDuration: Duration(milliseconds: 600),
  transitionEffect: FadeEffect(),
  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
)
```

### Gap between texts

Insert static separator text between sequence items using `SequenceText` with no effects:

```dart
AnimatedTextSequence(
  texts: [
    SequenceText('Hello', effects: const [FadeEffect()]),
    SequenceText(' • ', effects: const []),  // static gap
    SequenceText('World', effects: const [FadeEffect()]),
  ],
  repeat: true,
  style: TextStyle(fontSize: 28),
)
```

### AnimatedRichText — inline static + animated segments

Mix static text with animated segments inside a single widget:

```dart
AnimatedRichText(
  segments: [
    const TextSegment.static('Static prefix '),
    TextSegment.animated('Animated!', effects: const [FadeEffect(), WaveEffect()]),
    const TextSegment.static(' Static suffix'),
  ],
  repeat: true,
  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
)
```

## 🚀 Getting started

### Import

```dart
import 'package:animated_text_effects/animated_text_effects.dart';
```

## 📖 Usage

### Basic — single effect

```dart
AnimatedText(
  'Hello World',
  effects: const [FadeEffect()],
  style: TextStyle(fontSize: 32),
)
```

### Loop modes

```dart
// Infinite forward
AnimatedText(text, effects: const [WaveEffect()], repeat: true);

// Ping-pong (requires repeat: true)
AnimatedText(text, effects: const [BounceEffect()], repeat: true, reverse: true);
```

### Multiple combined effects

```dart
AnimatedText(
  'Fade + Wave + Gradient',
  effects: const [
    FadeEffect(delayBetweenChars: Duration(milliseconds: 30)),
    WaveEffect(scaleMin: 0.8, scaleMax: 1.2),
    GradientEffect(colors: [Colors.cyan, Colors.purple, Colors.orange]),
  ],
  repeat: true,
  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
)
```

### External controller

```dart
final controller = TextEffectController();

AnimatedText('Controlled text', effects: const [FadeEffect()], controller: controller);

controller.play();
controller.pause();
controller.stop();
controller.repeat();                  // infinite forward
controller.repeat(reverse: true);     // ping-pong
controller.repeat(count: 3);          // finite count
controller.seekTo(0.5);              // jump to 50%
```

### Scroll persistence

`AnimatedText` and `AnimatedCounter` preserve animation state when scrolling off-screen:

```dart
AnimatedText('Stays alive', effects: const [FadeEffect()], keepAlive: true);
AnimatedCounter(value: 42, keepAlive: true);
```

Use `TextEffectController` to persist state across widget mount/unmount cycles:

```dart
final controller = TextEffectController();

@override
void dispose() {
  controller.dispose(); // saves progress internally
  super.dispose();
}
```

## 🎛️ Effect reference

### FadeEffect

```dart
FadeEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeInOut,
  Duration delayBetweenChars = 50ms,
  double opacityFrom = 0.0,
  double opacityTo = 1.0,
})
```

### GradientEffect

```dart
GradientEffect({
  Duration duration = 2000ms,
  Curve curve = Curves.linear,
  List<Color> colors = [Colors.blue, Colors.purple, Colors.pink],
  Axis direction = Axis.horizontal,
})
```

### WaveEffect

```dart
WaveEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  double scaleMin = 0.5,
  double scaleMax = 1.5,
  int waveCount = 2,
})
```

### TypewriterEffect

```dart
TypewriterEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.linear,
  Duration delayBetweenChars = 80ms,
  String cursor = '|',
  Color? cursorColor,
})
```

### BounceEffect

```dart
BounceEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeOut,
  double height = 12.0,
  int bounceCount = 1,
  Duration delayBetweenChars = 60ms,
})
```

### ShimmerEffect

```dart
ShimmerEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  Color baseColor = Colors.grey,
  Color highlightColor = Colors.white,
  double width = 0.3,
})
```

### SlideEffect

```dart
SlideEffect({
  Duration duration = 800ms,
  Curve curve = Curves.easeOut,
  Duration delayBetweenChars = 30ms,
  SlideDirection direction = SlideDirection.left,
  double distance = 50.0,
})
```

Directions: `left`, `right`, `up`, `down`, `topLeft`, `topRight`, `bottomLeft`, `bottomRight`.

### BlurEffect

```dart
BlurEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeOut,
  Duration delayBetweenChars = 40ms,
  double sigmaFrom = 8.0,
  double sigmaTo = 0.0,
})
```

### RainbowEffect

```dart
RainbowEffect({
  Duration duration = 2000ms,
  Curve curve = Curves.linear,
  double saturation = 0.8,
  double lightness = 0.5,
})
```

### GlowEffect

```dart
GlowEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  Color color = Colors.cyan,
  double radius = 8.0,
  double minOpacity = 0.2,
  double maxOpacity = 0.8,
})
```

### RippleEffect

```dart
RippleEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeOut,
  Color? color,
  double scale = 1.5,
  double opacityFrom = 0.6,
})
```

### SpinEffect

```dart
SpinEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  double rotations = 1,
})
```

### FlipEffect

```dart
FlipEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeInOut,
  double angleFrom = 0.0,
  double angleTo = 3.1416,
})
```

### WiggleEffect

```dart
WiggleEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeInOut,
  double maxAngle = 0.2,
})
```

### PulseEffect

```dart
PulseEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeInOut,
  double scaleMin = 0.8,
  double scaleMax = 1.2,
})
```

### ScatterEffect

```dart
ScatterEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeOut,
  double maxOffset = 80.0,
})
```

### NeonFlickerEffect

```dart
NeonFlickerEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.linear,
  Color color = Colors.cyan,
  double glowRadius = 10.0,
})
```

### ElasticEffect

```dart
ElasticEffect({
  Duration duration = 1200ms,
  Curve curve = Curves.elasticOut,
  double height = 20.0,
})
```

### HighlightEffect

```dart
HighlightEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  Color color = Colors.yellow,
  double opacity = 0.4,
})
```

### UnderlineEffect

```dart
UnderlineEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  Color color = Colors.blue,
  double height = 3.0,
})
```

### ProgressTextEffect

```dart
ProgressTextEffect({
  Duration duration = 2000ms,
  Curve curve = Curves.linear,
  Color activeColor = Colors.green,
  Color inactiveColor = Colors.grey,
})
```

### StaggeredAppearEffect

```dart
StaggeredAppearEffect({
  Duration duration = 1200ms,
  Curve curve = Curves.easeOut,
  Duration delayBetweenChars = 40ms,
  SlideDirection direction = SlideDirection.down,
  double distance = 30.0,
})
```

### FireEffect

```dart
FireEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.linear,
  double intensity = 1.0,
})
```

### SmokeEffect

```dart
SmokeEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeOut,
  double drift = 20.0,
})
```

### VHSGlitchEffect

```dart
VHSGlitchEffect({
  Duration duration = 800ms,
  Curve curve = Curves.linear,
})
```

### RevealEffect

```dart
RevealEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeOut,
  RevealDirection direction = RevealDirection.left,
})
```

Directions: `left`, `right`, `up`, `down`.

### LiquidEffect

```dart
LiquidEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  double waveHeight = 15.0,
  List<Color>? colors,
})
```

### ScannerEffect

```dart
ScannerEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  Color lineColor = Colors.cyan,
  double lineWidth = 4.0,
})
```

### WaveColorEffect

```dart
WaveColorEffect({
  Duration duration = 2000ms,
  Curve curve = Curves.linear,
  List<Color> colors = const [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.indigo, Colors.violet],
})
```

### BreathingOpacityEffect

```dart
BreathingOpacityEffect({
  Duration duration = 2000ms,
  Curve curve = Curves.sine,
  double minOpacity = 0.3,
  double maxOpacity = 1.0,
})
```

### ConveyorBeltEffect

```dart
ConveyorBeltEffect({
  Duration duration = 2000ms,
  Curve curve = Curves.linear,
  double distance = 60.0,
})
```

### MeltDripEffect

```dart
MeltDripEffect({
  Duration duration = 1200ms,
  Curve curve = Curves.easeIn,
  double stretch = 30.0,
})
```

### SparkleTwinkleEffect

```dart
SparkleTwinkleEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.linear,
  Color sparkleColor = Colors.white,
  double probability = 0.3,
})
```

### MatrixRainEffect

```dart
MatrixRainEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.linear,
  Color rainColor = Colors.green,
  double fallDistance = 40.0,
})
```

### ScrambleEffect

```dart
ScrambleEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeInOut,
  Duration delayBetweenChars = 60ms,
  String charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789',
  int seed = 42,
})
```

Characters temporarily show random chars from `charset` (via `character` override) at progress 0, resolving to the actual text at progress 1. The `seed` controls the deterministic scramble pattern.

### PopInEffect

```dart
PopInEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeOutBack,
  Duration delayBetweenChars = 60ms,
  double scaleFrom = 0.0,
  double scalePeak = 1.2,
  double opacityFrom = 0.0,
})
```

Characters scale up from `scaleFrom` past 1.0 to `scalePeak` before settling at 1.0, creating a playful overshoot entrance.

### ShakeEffect

```dart
ShakeEffect({
  Duration duration = 800ms,
  Curve curve = Curves.easeOut,
  double intensity = 4.0,
  double rotationAmplitude = 0.1,
})
```

Each character jitters with decreasing intensity towards progress 1, simulating an earthquake or vibration effect.

### FlagWaveEffect

```dart
FlagWaveEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  double amplitude = 0.3,
  int waveCount = 2,
})
```

Applies a 3D rotationY wave across characters, creating a flag-waving effect. Characters at the same index have the same rotation for a cohesive wave.

### RandomRevealEffect

```dart
RandomRevealEffect({
  Duration duration = 1500ms,
  Curve curve = Curves.easeInOut,
  Duration delayBetweenChars = Duration.zero,
  double opacityFrom = 0.0,
  double scaleFrom = 0.5,
  int seed = 42,
})
```

Characters reveal in a random order (determined by `seed`) instead of left-to-right, each fading/scaling in independently based on noise threshold.

### GlitchSplitEffect

```dart
GlitchSplitEffect({
  Duration duration = 600ms,
  Curve curve = Curves.linear,
  double maxOffset = 10.0,
})
```

### TrackingEffect

```dart
TrackingEffect({
  Duration duration = 800ms,
  Curve curve = Curves.easeOut,
  Duration delayBetweenChars = Duration.zero,
  double spacing = 30.0,
  bool fromCenter = true,
})
```

Characters spread apart horizontally. When `fromCenter` is `true` (default), text expands outward from the center; when `false`, characters shift rightward linearly.

### GlowRevealEffect

```dart
GlowRevealEffect({
  Duration duration = 1200ms,
  Curve curve = Curves.easeOut,
  Duration delayBetweenChars = 30ms,
  double blurSigmaFrom = 10.0,
  double scaleFrom = 1.4,
})
```

Each character blooms from a blurred, slightly enlarged state to sharp and fully opaque. A subtle pulse adds cinematic depth.

### KineticTypeEffect

```dart
KineticTypeEffect({
  Duration duration = 2000ms,
  Curve curve = Curves.linear,
  Duration delayBetweenChars = Duration.zero,
  double amplitude = 4.0,
  double waveCount = 2.0,
  double rotationAmplitude = 0.03,
})
```

A continuous wave of vertical bob + slight rotation + scale — reminiscent of Apple keynote kinetic typography. All characters move simultaneously for a fluid, organic feel.

### SplitRevealEffect

```dart
SplitRevealEffect({
  Duration duration = 700ms,
  Curve curve = Curves.easeOut,
  Duration delayBetweenChars = 20ms,
  double distance = 80.0,
})
```

Characters on the left half slide in from the left, characters on the right half slide in from the right, and the center character appears in place. Creates a satisfying symmetrical reveal.

### InkDropsEffect

```dart
InkDropsEffect({
  Duration duration = 1000ms,
  Curve curve = Curves.easeOut,
  Duration delayBetweenChars = Duration.zero,
  int dropCount = 3,
  double spreadDistance = 100.0,
  int seed = 42,
})
```

Characters reveal outward from random ink drop points. Each character scales up from 0.3, fades in, and sharpens as the ink spreads. The `seed` parameter controls deterministic drop placement.

## 📟 Counter widgets reference

### AnimatedCounter

```dart
AnimatedCounter({
  required num value,
  Duration duration = 1000ms,
  Curve curve = easeOut,
  TextStyle? style,
  int decimals = 0,
  Color? activeColor,
  bool scalePulse = false,
  bool autoplay = true,
  bool keepAlive = true,
  String Function(num)? format,
})
```

### AnimatedPercentage

```dart
AnimatedPercentage({
  required num value,
  int decimals = 1,
  Duration duration = 1000ms,
  Curve curve = easeOut,
  TextStyle? style,
  bool autoplay = true,
  bool keepAlive = true,
  Color? activeColor,
  bool scalePulse = false,
  bool showPercentSign = true,
})
```

### AnimatedCurrency

```dart
AnimatedCurrency({
  required num value,
  int decimals = 2,
  String symbol = r'$',
  Duration duration = 1000ms,
  Curve curve = easeOut,
  TextStyle? style,
  bool autoplay = true,
  bool keepAlive = true,
  Color? activeColor,
  bool scalePulse = false,
  bool showPlusSign = false,
})
```

### AnimatedStatCard

```dart
AnimatedStatCard({
  required num value,
  required String label,
  IconData? icon,
  int decimals = 0,
  Duration duration = 1000ms,
  Curve curve = easeOut,
  TextStyle? valueStyle,
  TextStyle? labelStyle,
  Color? activeColor,
  bool scalePulse = false,
  Color? cardColor,
  double elevation = 2,
  EdgeInsetsGeometry padding = EdgeInsets.all(20),
  bool autoplay = true,
  String Function(num)? format,
})
```

### RollingDigitCounter

```dart
RollingDigitCounter({
  required num value,
  int decimals = 0,
  Duration duration = 1000ms,
  TextStyle? style,
  bool autoplay = true,
  bool keepAlive = true,
  double digitWidth = 28,
  double digitHeight = 40,
  Color? backgroundColor,
})
```

## 🧩 AnimatedText widget API

| Parameter | Type | Default | Description |
|---|---|---|---|
| `text` | `String` | — | Text to animate |
| `effects` | `List<TextEffect>` | `[]` | Effects to apply (order matters for color) |
| `controller` | `TextEffectController?` | `null` | External playback control |
| `style` | `TextStyle?` | inherits | Text styling |
| `autoplay` | `bool` | `true` | Start animation automatically |
| `repeat` | `bool` | `false` | Loop infinitely |
| `reverse` | `bool` | `false` | Ping-pong (requires `repeat: true`) |
| `textAlign` | `TextAlign` | `start` | Text alignment |
| `textDirection` | `TextDirection` | `ltr` | Text direction |
| `keepAlive` | `bool` | `true` | Persist animation in scroll views |

## 🧩 CharacterAnimation properties

| Property | Type | Combined as | Description |
|---|---|---|---|
| `opacity` | `double` | Multiplied | Character opacity |
| `translation` | `Offset` | Summed | Displacement from origin |
| `scale` | `double` | Multiplied | Uniform scale |
| `scaleX` | `double` | Multiplied | Horizontal scale |
| `scaleY` | `double` | Multiplied | Vertical scale |
| `color` | `Color?` | Last non-null wins | Text color |
| `backgroundColor` | `Color?` | Last non-null wins | Background behind character |
| `blurSigma` | `double` | Summed | Gaussian blur |
| `rotation` | `double` | Summed | 2D rotation (radians) |
| `rotationX` | `double` | Summed | 3D X rotation (radians) |
| `rotationY` | `double` | Summed | 3D Y rotation (radians) |
| `underlineProgress` | `double` | Summed | Underline fill (0–1) |
| `clipProgress` | `double` | Multiplied | Visible portion (0–1) |

## 🧪 Composing effects

| Property | Combination rule |
|---|---|
| `opacity` | **Multiplied** across effects |
| `translation` | **Summed** across effects |
| `scale`, `scaleX`, `scaleY` | **Multiplied** across effects |
| `color`, `backgroundColor` | **Last non-null** wins |
| `blurSigma`, `rotation`, `rotationX`, `rotationY`, `underlineProgress` | **Summed** across effects |
| `clipProgress` | **Multiplied** across effects |

## 🧩 Sequence widgets API

### AnimatedTextSequence

| Parameter | Type | Default | Description |
|---|---|---|---|
| `texts` | `List<SequenceText>` | — | Ordered list of text items to cycle through |
| `controller` | `TextEffectController?` | `null` | External playback control |
| `style` | `TextStyle?` | inherits | Text styling (applied to all texts) |
| `autoplay` | `bool` | `true` | Start animation automatically |
| `repeat` | `bool` | `true` | Loop infinitely through the sequence |
| `displayDuration` | `Duration` | `3s` | How long each text is displayed |
| `transitionDuration` | `Duration` | `500ms` | Duration of the cross-fade between texts |
| `transitionEffect` | `TextEffect?` | `null` | Effect applied during transitions (null = plain cross-fade) |
| `textAlign` | `TextAlign` | `start` | Text alignment |
| `textDirection` | `TextDirection` | `ltr` | Text direction |
| `keepAlive` | `bool` | `true` | Persist animation in scroll views |

### SequenceText

| Parameter | Type | Default | Description |
|---|---|---|---|
| `text` | `String` | — | Text content for this item |
| `effects` | `List<TextEffect>` | `[]` | Effects to apply when this text is displayed |
| `style` | `TextStyle?` | `null` | Per-item text style override |
| `segments` | `List<TextSegment>?` | `null` | Fine-grained segment control (for mixed static/animated within one item) |

### AnimatedRichText

| Parameter | Type | Default | Description |
|---|---|---|---|
| `segments` | `List<TextSegment>` | — | Ordered list of static or animated text segments |
| `controller` | `TextEffectController?` | `null` | External playback control |
| `style` | `TextStyle?` | inherits | Base text styling |
| `autoplay` | `bool` | `true` | Start animation automatically |
| `repeat` | `bool` | `false` | Loop infinitely |
| `reverse` | `bool` | `false` | Ping-pong (requires `repeat: true`) |
| `textAlign` | `TextAlign` | `start` | Text alignment |
| `textDirection` | `TextDirection` | `ltr` | Text direction |
| `keepAlive` | `bool` | `true` | Persist animation in scroll views |

### TextSegment

| Constructor | Parameters | Description |
|---|---|---|
| `TextSegment.static(text)` | `text` | Non-animated text segment |
| `TextSegment.animated(text, {effects})` | `text`, `effects` | Animated text segment with optional effects |

## 📐 Effect contract

All effects guarantee `f(0) == f(1)` — at `progress=0` and `progress=1` every character returns to its base state. This ensures seamless looping and predictable end states.

Noise-based effects (`FireEffect`, `NeonFlickerEffect`, `VHSGlitchEffect`, `WiggleEffect`, `SparkleTwinkleEffect`) wrap their output to enforce this contract.

Use `noise(int index, [int offset])` on `TextEffect` for deterministic pseudo-random values per character:

```dart
final value = noise(index);       // 0.0–1.0 per character
final value = noise(index, 42);   // with offset for different noise streams
```

## 🔄 Scroll persistence

Animations survive scrolling off-screen by default (`keepAlive: true`). This uses `AutomaticKeepAliveClientMixin` under the hood.

For more advanced persistence across widget mount/unmount (e.g., conditional rendering), use `TextEffectController` which saves its progress internally on detach and restores on attach:

```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with SingleTickerProviderStateMixin {
  final controller = TextEffectController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showText)
          AnimatedText(
            'Persistent text',
            effects: const [FadeEffect(), WaveEffect()],
            controller: controller,
          ),
      ],
    );
  }
}
```

## 🎮 Interactive demos

The example app includes two interactive demos reachable from the AppBar:

- **Text** — multi-effect checkboxes with per-effect parameter sliders (all 45 effects)
- **Counters** — all 5 counter types with global controls (value, decimals, duration, curve, color, scale pulse) and a reset button that recreates all widgets from scratch
- **Sequence** — interactive `AnimatedTextSequence` with per-text effect selection and transition effect picker
- **Comprehensive** — tabbed demo (Static Text, Sequence, Mixed) with gap support, per-text effects, color, curve, and font size controls
- **Cmp Counters** — tabbed counter demo (Single, Dashboard, Mixed) with inline prefix/suffix text mixing

```bash
cd example
flutter run
```

## 🏗️ Architecture

```
lib/
├── animated_text_effects.dart    # Barrel exports
├── core/
│   ├── text_effect.dart          # Abstract base with noise() helper
│   ├── text_effect_controller.dart  # Playback controller with attach/detach
│   ├── character_animation.dart  # Per-character animation data
│   ├── animated_text.dart        # Main AnimatedText widget
│   ├── text_segment.dart         # Static or animated segment for AnimatedRichText
│   ├── sequence_text.dart        # Text item with effects for AnimatedTextSequence
│   ├── animated_rich_text.dart   # Inline static + animated text segments
│   ├── animated_text_sequence.dart  # Sequential multi-text playback with transitions
│   └── animated_counter.dart     # AnimatedCounter base widget
├── effects/                      # 45 effect implementations
│   ├── fade_effect.dart
│   ├── gradient_effect.dart
│   ├── wave_effect.dart
│   ├── typewriter_effect.dart
│   ├── bounce_effect.dart
│   ├── shimmer_effect.dart
│   ├── slide_effect.dart
│   ├── blur_effect.dart
│   ├── rainbow_effect.dart
│   ├── glow_effect.dart
│   ├── ripple_effect.dart
│   ├── spin_effect.dart
│   ├── flip_effect.dart
│   ├── wiggle_effect.dart
│   ├── pulse_effect.dart
│   ├── scatter_effect.dart
│   ├── neon_flicker_effect.dart
│   ├── elastic_effect.dart
│   ├── highlight_effect.dart
│   ├── underline_effect.dart
│   ├── progress_text_effect.dart
│   ├── staggered_appear_effect.dart
│   ├── fire_effect.dart
│   ├── smoke_effect.dart
│   ├── vhs_glitch_effect.dart
│   ├── reveal_effect.dart
│   ├── liquid_effect.dart
│   ├── scanner_effect.dart
│   ├── wave_color_effect.dart
│   ├── breathing_opacity_effect.dart
│   ├── conveyor_belt_effect.dart
│   ├── melt_drip_effect.dart
│   ├── sparkle_twinkle_effect.dart
│   ├── matrix_rain_effect.dart
│   ├── scramble_effect.dart
│   ├── pop_in_effect.dart
│   ├── shake_effect.dart
│   ├── flag_wave_effect.dart
│   ├── tracking_effect.dart
│   ├── glow_reveal_effect.dart
│   ├── kinetic_type_effect.dart
│   ├── split_reveal_effect.dart
│   ├── ink_drops_effect.dart
│   └── random_reveal_effect.dart
│   └── glitch_split_effect.dart
└── counters/                     # Counter widgets
    ├── animated_percentage.dart
    ├── animated_currency.dart
    ├── animated_stat_card.dart
    └── rolling_digit_counter.dart
```

## 📄 License

MIT
