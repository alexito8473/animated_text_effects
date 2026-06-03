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
