# animated_text_effects

A Flutter package for text with **35 composable animation effects** and **4 animated counter widgets**. Combine effects freely, control playback, and persist state across scroll off-screen.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.3%2B-blue" alt="Flutter">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License">
  <img src="https://img.shields.io/badge/version-0.0.1-orange" alt="Version">
</p>

---

## ✨ Features

- **35 effects** — fade, wave, typewriter, fire, smoke, matrix rain, glitch, and more
- **Composable** — apply multiple effects simultaneously (opacity multiplies, translation sums, last color wins)
- **Loop modes** — forward, ping-pong, or finite repeat counts
- **External controller** — `TextEffectController` for play/pause/stop/seek
- **Scroll persistence** — animations survive scrolling off-screen via `keepAlive` (default `true`)
- **Counter widgets** — `AnimatedCounter`, `AnimatedPercentage`, `AnimatedCurrency`, `AnimatedStatCard`, `RollingDigitCounter`
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

## 📟 Counter Widgets

| Widget | Description |
|---|---|
| `AnimatedCounter` | Generic animated number (int or double) with color lerp and scale pulse |
| `AnimatedPercentage` | `AnimatedCounter` with `%` suffix |
| `AnimatedCurrency` | `AnimatedCounter` with symbol, thousands separator, plus sign |
| `AnimatedStatCard` | Material card with icon, label, and `AnimatedCounter` |
| `RollingDigitCounter` | Digit-box style counter with per-character boxes |

## 🚀 Getting started

### Installation

```yaml
dependencies:
  animated_text_effects:
    git:
      url: https://github.com/your-username/animated_text_effects
```

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

### GlitchSplitEffect

```dart
GlitchSplitEffect({
  Duration duration = 600ms,
  Curve curve = Curves.linear,
  double maxOffset = 10.0,
})
```

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

- **Text** — multi-effect checkboxes with per-effect parameter sliders (all 35 effects)
- **Counters** — all 5 counter types with global controls (value, decimals, duration, curve, color, scale pulse) and a reset button that recreates all widgets from scratch

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
│   └── animated_counter.dart     # AnimatedCounter base widget
├── effects/                      # 35 effect implementations
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
│   └── glitch_split_effect.dart
└── counters/                     # Counter widgets
    ├── animated_percentage.dart
    ├── animated_currency.dart
    ├── animated_stat_card.dart
    └── rolling_digit_counter.dart
```

## 📄 License

MIT
