## 0.0.4

- **5 new effects**: Tracking, Glow Reveal, Kinetic Type, Split Reveal, Ink Drops
- **New**: `AnimatedTextSequence` — cycle through a list of texts with individual effects, transition animations, and configurable display/transition durations
- **New**: `SequenceText` — typed text item with per-text effects and optional gap/separator support
- **New**: `AnimatedRichText` — mix static and animated `TextSegment`s inline within a single widget
- **New**: `TextSegment.static` / `TextSegment.animated` — fine-grained segment control
- **New**: Interactive Sequence demo (`SequenceInteractiveDemo`) with per-text effect selection and transition picker
- **New**: Comprehensive demo (`ComprehensiveDemo`) — 3-tab view (Static Text, Sequence, Mixed) with gap support, color, curve, and font size controls
- **New**: Comprehensive counters demo (`ComprehensiveCountersDemo`) — 3-tab view (Single, Dashboard, Mixed) with inline prefix/suffix text mixing
- **New**: `fromCenter` parameter on `TrackingEffect` — controls whether spacing expands from center or rightward
- **New**: `seed` parameter on `InkDropsEffect` — deterministic drop placement
- **Fixes**: Counter odometer digit width adjusted from 28→42 to prevent character clipping
- **Improvements**: README updated with all new effects, sequence widgets API docs, and comprehensive demo descriptions
- **Tests**: 314 tests (all pass), covering 45 effects + all counters + sequence widgets

## 0.0.3

- **New**: `example/main.dart` — complete API reference with 40 effects, composition rules, controllers, counters, and widget examples (pub.dev example score)
- **Fixes**: All 14 failing tests corrected (GlowEffect, PulseEffect, SpinEffect, WiggleEffect, ProgressTextEffect, WaveColorEffect, ElasticEffect test, GradientEffect test, AnimatedText test, etc.)
- **Fixes**: `TextEffect.applyCurve` now clamps input before curve transform (prevents assertion on out-of-range values)
- **Improvements**: `example/main.dart` uses raw `r'''` strings for safe `$` symbol display in currency example

## 0.0.2

- **5 new effects**: Scramble, Pop In, Shake, Flag Wave, Random Reveal
- **New**: `character` field on `CharacterAnimation` for per-character text override
- **Fixes**: GlowEffect, PulseEffect, SpinEffect, WiggleEffect, ProgressTextEffect, WaveColorEffect now properly return identity at both extremes
- **Fixes**: `TextEffect.applyCurve` clamps input before curve transform to prevent assertion errors
- **Tests**: 289 tests (all pass), up from 48 in 0.0.1

## 0.0.1

Initial release.

### AnimatedText — 35 effects

- **Fade** — characters fade in sequentially
- **Gradient** — animated color sweep across text
- **Wave** — characters scale up/down in a wave pattern
- **Typewriter** — classic typewriter reveal with cursor
- **Bounce** — characters bounce vertically in sequence
- **Shimmer** — highlight sweep across the text
- **Slide** — characters slide in from any direction (8 directions)
- **Blur** — characters transition blurry to sharp
- **Rainbow** — cycling rainbow colors per character
- **Glow** — pulsing glow behind text
- **Ripple** — circular ripple from center outward
- **Spin** — characters rotate around their center
- **Flip** — characters flip horizontally
- **Wiggle** — random-angle jitter per character
- **Pulse** — scale pulsing rhythm
- **Scatter** — characters fly in from random offsets
- **Neon Flicker** — random flicker with glow color
- **Elastic** — overshoot bounce with elastic curve
- **Highlight** — background color highlight sweep
- **Underline** — animated underline per character
- **Progress Text** — binary color switch left-to-right
- **Staggered Appear** — sequential slide + opacity from any direction
- **Fire** — flickering orange/red/yellow flames
- **Smoke** — rising smoky particles that fade
- **VHS Glitch** — scan lines + color shift + jitter
- **Reveal** — clip-reveal from top/bottom/left/right
- **Liquid** — wavy distortion + gradient swoosh
- **Scanner** — scanning line reveal with clip
- **Wave Color** — color wave across characters
- **Breathing Opacity** — slow pulsing opacity
- **Conveyor Belt** — characters loop horizontally
- **Melt Drip** — stretch + slide down like melting
- **Sparkle Twinkle** — random sparkle highlights
- **Matrix Rain** — green rain characters falling
- **Glitch Split** — horizontal split with offset jitter

### Counter widgets — 5 animated counters

- **AnimatedCounter** — generic animated number (int/double) with decimals, color lerp, and scale pulse
- **AnimatedPercentage** — AnimatedCounter with `%` suffix
- **AnimatedCurrency** — AnimatedCounter with symbol, thousands separator, and plus sign
- **AnimatedStatCard** — Material card with icon, label, and AnimatedCounter
- **RollingDigitCounter** — digit-box style counter with per-character boxes

### Key features

- Multi-effect composability (opacity multiplies, translation sums, last color wins)
- Loop modes: forward, ping-pong, and finite repeat counts
- External playback control via `TextEffectController` (play/pause/stop/seek/attach/detach)
- Scroll persistence: animations survive scrolling off-screen (`keepAlive` + `AutomaticKeepAliveClientMixin`)
- `TextEffectController.attach/detach` preserves animation progress across widget mount/unmount
- All effects guarantee `f(0) == f(1)` for seamless looping
- Deterministic `noise()` helper for per-character pseudo-random values
- Interactive demo app with real-time parameter controls for all effects and counters
