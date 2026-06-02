# animated_text_effects

A Flutter plugin for text with multiple composable animation effects. Bring your text to life with fade, wave, gradient, typewriter, bounce, shimmer, slide, and blur effects — combinable and controllable.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.3%2B-blue" alt="Flutter">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="License">
  <img src="https://img.shields.io/badge/version-0.0.1-orange" alt="Version">
</p>

---

## ✨ Effects

| Effect | Widget | Description |
|---|---|---|
| **Fade** | `FadeEffect` | Characters appear sequentially from invisible to visible |
| **Gradient** | `GradientEffect` | Animated color sweep across the text |
| **Wave** | `WaveEffect` | Characters scale up/down in a wave pattern |
| **Typewriter** | `TypewriterEffect` | Classic typewriter reveal |
| **Bounce** | `BounceEffect` | Characters bounce vertically in sequence |
| **Shimmer** | `ShimmerEffect` | A highlight sweeps across the text |
| **Slide** | `SlideEffect` | Characters slide in from any direction |
| **Blur** | `BlurEffect` | Characters transition from blurry to sharp |

## 🚀 Getting started

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  animated_text_effects:
    git:
      url: https://github.com/your-username/animated_text_effects
```

Or for local development:

```yaml
dependencies:
  animated_text_effects:
    path: ../animated_text_effects
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

### Loop mode — infinite playback

```dart
AnimatedText(
  'Looping text',
  effects: const [WaveEffect()],
  repeat: true,
)
```

### Ping-pong (reverse loop)

```dart
AnimatedText(
  'Bouncing text',
  effects: const [BounceEffect()],
  repeat: true,
  reverse: true,
)
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

### With controller (play/pause/stop/seek)

```dart
final controller = TextEffectController();

AnimatedText(
  'Controlled text',
  effects: const [FadeEffect(), BounceEffect()],
  controller: controller,
)

// Control methods
controller.play();
controller.pause();
controller.stop();
controller.repeat();                  // infinite forward
controller.repeat(reverse: true);     // infinite ping-pong
controller.repeat(count: 3);          // 3 times
controller.seekTo(0.5);               // jump to 50%
```

> **Important**: Call `repeat()` or other control methods **after** the `AnimatedText` widget is built (e.g., in a button callback or post-frame callback). The underlying `AnimationController` is bound when the widget initializes.

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

Direction options: `left`, `right`, `up`, `down`, `topLeft`, `topRight`, `bottomLeft`, `bottomRight`.

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

## 🧩 AnimatedText widget API

| Parameter | Type | Default | Description |
|---|---|---|---|
| `text` | `String` | — | The text to animate |
| `effects` | `List<TextEffect>` | `[]` | Effects to apply (order matters for color) |
| `controller` | `TextEffectController?` | `null` | External playback control |
| `style` | `TextStyle?` | inherits | Text styling |
| `autoplay` | `bool` | `true` | Start animation automatically |
| `repeat` | `bool` | `false` | Loop infinitely |
| `reverse` | `bool` | `false` | Ping-pong (requires `repeat: true`) |
| `textAlign` | `TextAlign` | `start` | Text alignment |
| `textDirection` | `TextDirection` | `ltr` | Text direction |

## 🧪 Composing effects

Effects are applied in list order. Properties combine as follows:

| Property | Combination rule |
|---|---|
| `opacity` | **Multiplied** across effects |
| `translation` | **Summed** across effects |
| `scale` | **Multiplied** across effects |
| `color` | **Last non-null** wins |
| `blurSigma` | **Summed** across effects |

## 🏗️ Architecture

```
lib/
├── animated_text_effects.dart    # Barrel export
├── core/
│   ├── text_effect.dart          # Abstract base class
│   ├── text_effect_controller.dart  # Playback controller
│   ├── character_animation.dart  # Per-character animation data
│   └── animated_text.dart        # Main widget
└── effects/
    ├── fade_effect.dart
    ├── gradient_effect.dart
    ├── wave_effect.dart
    ├── typewriter_effect.dart
    ├── bounce_effect.dart
    ├── shimmer_effect.dart
    ├── slide_effect.dart
    └── blur_effect.dart
```

## 📄 License

MIT
