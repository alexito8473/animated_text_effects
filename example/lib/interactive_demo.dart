import 'package:flutter/material.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

enum _EffectType {
  fade,
  gradient,
  wave,
  typewriter,
  bounce,
  shimmer,
  slide,
  blur,
  rainbow,
  glow,
  ripple,
  spin,
  flip,
  wiggle,
  pulse,
  scatter,
  neonFlicker,
  elastic,
  highlight,
  underline,
  progressText,
  staggeredAppear,
  fire,
  smoke,
  vhsGlitch,
  reveal,
  liquid,
  scanner,
  waveColor,
  breathingOpacity,
  conveyorBelt,
  meltDrip,
  sparkleTwinkle,
  matrixRain,
  glitchSplit,
}

const _curveOptions = [
  Curves.linear,
  Curves.easeInOut,
  Curves.easeIn,
  Curves.easeOut,
  Curves.bounceOut,
  Curves.elasticOut,
];

const _colorOptions = [
  Colors.white,
  Colors.grey,
  Colors.black,
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.cyan,
  Colors.blue,
  Colors.purple,
  Colors.pink,
  Colors.amber,
];

const _effectLabels = {
  _EffectType.fade: 'Fade',
  _EffectType.gradient: 'Gradient',
  _EffectType.wave: 'Wave',
  _EffectType.typewriter: 'Typewriter',
  _EffectType.bounce: 'Bounce',
  _EffectType.shimmer: 'Shimmer',
  _EffectType.slide: 'Slide',
  _EffectType.blur: 'Blur',
  _EffectType.rainbow: 'Rainbow',
  _EffectType.glow: 'Glow',
  _EffectType.ripple: 'Ripple',
  _EffectType.spin: 'Spin',
  _EffectType.flip: 'Flip',
  _EffectType.wiggle: 'Wiggle',
  _EffectType.pulse: 'Pulse',
  _EffectType.scatter: 'Scatter',
  _EffectType.neonFlicker: 'Neon Flicker',
  _EffectType.elastic: 'Elastic',
  _EffectType.highlight: 'Highlight',
  _EffectType.underline: 'Underline',
  _EffectType.progressText: 'Progress Text',
  _EffectType.staggeredAppear: 'Staggered Appear',
  _EffectType.fire: 'Fire',
  _EffectType.smoke: 'Smoke',
  _EffectType.vhsGlitch: 'VHS Glitch',
  _EffectType.reveal: 'Reveal',
  _EffectType.liquid: 'Liquid',
  _EffectType.scanner: 'Scanner',
  _EffectType.waveColor: 'Wave Color',
  _EffectType.breathingOpacity: 'Breathing Opacity',
  _EffectType.conveyorBelt: 'Conveyor Belt',
  _EffectType.meltDrip: 'Melt Drip',
  _EffectType.sparkleTwinkle: 'Sparkle Twinkle',
  _EffectType.matrixRain: 'Matrix Rain',
  _EffectType.glitchSplit: 'Glitch Split',
};

class InteractiveDemo extends StatefulWidget {
  const InteractiveDemo({super.key});

  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  late final TextEditingController _textController;
  late final TextEditingController _cursorController;
  String _text = 'Hello World';
  Set<_EffectType> _enabledEffects = {_EffectType.fade};
  int _durationMs = 1000;
  int _delayMs = 0;
  Curve _curve = Curves.easeInOut;
  bool _repeat = false;
  bool _reverse = false;

  double _fadeOpacityFrom = 0.0;
  double _fadeOpacityTo = 1.0;

  List<Color> _gradientColors = [Colors.blue, Colors.purple, Colors.pink];

  double _waveScaleMin = 0.5;
  double _waveScaleMax = 1.5;
  int _waveCount = 2;

  String _typewriterCursor = '|';
  Color? _typewriterCursorColor;

  double _bounceHeight = 12.0;
  int _bounceCount = 1;

  Color _shimmerBase = Colors.grey;
  Color _shimmerHighlight = Colors.white;
  double _shimmerWidth = 0.3;

  SlideDirection _slideDirection = SlideDirection.left;
  double _slideDistance = 50.0;

  double _blurSigmaFrom = 8.0;
  double _blurSigmaTo = 0.0;

  double _rainbowSaturation = 0.8;
  double _rainbowLightness = 0.6;
  int _rainbowCycleCount = 1;

  double _glowBlurMin = 3.0;
  double _glowBlurMax = 12.0;
  double _glowOpacityMin = 0.6;
  double _glowOpacityMax = 1.0;
  Color? _glowColor;

  double _rippleScaleMin = 0.5;
  double _rippleScaleMax = 1.3;
  double _rippleHeight = 20.0;
  double _rippleOpacityMin = 0.0;

  int _spinCount = 1;
  double _spinScaleFrom = 0.0;

  int _flipCount = 1;
  bool _flipAxis = true;

  double _wiggleAmplitude = 4.0;
  double _wiggleFrequency = 3.0;
  double _wiggleRotationAmplitude = 0.05;

  double _pulseScaleMin = 1.0;
  double _pulseScaleMax = 1.3;
  double _pulseOpacityMin = 0.85;

  double _scatterDistance = 150.0;

  Color _neonBaseColor = Colors.cyan;
  Color _neonGlowColor = Colors.cyan;
  double _neonBlurSigma = 6.0;
  final int _neonFlickerSeed = 42;

  double _elasticStretch = 0.3;
  int _elasticBounceCount = 1;

  Color _highlightColor = Colors.yellow;
  double _highlightOpacityFrom = 0.0;
  double _highlightOpacityTo = 0.6;

  Color _underlineLineColor = Colors.white;
  double _underlineHeight = 2.0;

  Color _progressFilledColor = Colors.green;
  Color _progressEmptyColor = Colors.grey;

  SlideDirection _staggeredDirection = SlideDirection.down;
  double _staggeredDistance = 30.0;
  double _staggeredOpacityFrom = 0.0;

  double _fireJitter = 3.0;
  double _fireBlurSigma = 4.0;
  double _fireMaxScale = 1.15;

  double _smokeHeight = 40.0;
  double _smokeBlurSigma = 6.0;

  double _vhsJitter = 8.0;
  double _vhsColorOffset = 4.0;
  double _vhsMaxBlur = 1.5;

  bool _revealHorizontal = true;

  double _liquidAmplitude = 0.3;
  double _liquidFrequency = 2.0;
  double _liquidWaveHeight = 6.0;

  Color _scannerColor = Colors.cyan;
  double _scannerScanWidth = 0.15;
  double _scannerGlowWidth = 0.3;

  Color _waveColorA = Colors.blue;
  Color _waveColorB = Colors.purple;
  int _waveColorCount = 2;

  double _breathingOpacityMin = 0.7;

  double _conveyorSpacing = 30.0;
  bool _conveyorReverse = false;

  double _meltAmount = 0.5;
  double _meltDripHeight = 40.0;
  double _meltBlurSigma = 3.0;

  Color _sparkleColor = Colors.amber;
  double _sparkleScale = 1.4;
  double _sparkleBlur = 4.0;

  Color _matrixGreen = Colors.green;
  double _matrixFallSpeed = 1.0;
  double _matrixBlurSigma = 2.0;

  double _glitchSplitAmount = 4.0;
  double _glitchProbability = 0.3;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _text);
    _cursorController = TextEditingController(text: _typewriterCursor);
  }

  @override
  void dispose() {
    _textController.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  List<TextEffect> _buildEffects() {
    final effects = <TextEffect>[];
    for (final type in _enabledEffects) {
      effects.add(_buildSingleEffect(type));
    }
    return effects;
  }

  TextEffect _buildSingleEffect(_EffectType type) {
    switch (type) {
      case _EffectType.fade:
        return FadeEffect(
          duration: Duration(milliseconds: _durationMs),
          delayBetweenChars: Duration(milliseconds: _delayMs),
          curve: _curve,
          opacityFrom: _fadeOpacityFrom,
          opacityTo: _fadeOpacityTo,
        );
      case _EffectType.gradient:
        return GradientEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          colors: _gradientColors,
        );
      case _EffectType.wave:
        return WaveEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          scaleMin: _waveScaleMin,
          scaleMax: _waveScaleMax,
          waveCount: _waveCount,
        );
      case _EffectType.typewriter:
        return TypewriterEffect(
          duration: Duration(milliseconds: _durationMs),
          delayBetweenChars: Duration(milliseconds: _delayMs),
          curve: _curve,
          cursor: _typewriterCursor,
          cursorColor: _typewriterCursorColor,
        );
      case _EffectType.bounce:
        return BounceEffect(
          duration: Duration(milliseconds: _durationMs),
          delayBetweenChars: Duration(milliseconds: _delayMs),
          curve: _curve,
          height: _bounceHeight,
          bounceCount: _bounceCount,
        );
      case _EffectType.shimmer:
        return ShimmerEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          baseColor: _shimmerBase,
          highlightColor: _shimmerHighlight,
          width: _shimmerWidth,
        );
      case _EffectType.slide:
        return SlideEffect(
          duration: Duration(milliseconds: _durationMs),
          delayBetweenChars: Duration(milliseconds: _delayMs),
          curve: _curve,
          direction: _slideDirection,
          distance: _slideDistance,
        );
      case _EffectType.blur:
        return BlurEffect(
          duration: Duration(milliseconds: _durationMs),
          delayBetweenChars: Duration(milliseconds: _delayMs),
          curve: _curve,
          sigmaFrom: _blurSigmaFrom,
          sigmaTo: _blurSigmaTo,
        );
      case _EffectType.rainbow:
        return RainbowEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          saturation: _rainbowSaturation,
          lightness: _rainbowLightness,
          cycleCount: _rainbowCycleCount,
        );
      case _EffectType.glow:
        return GlowEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          blurMin: _glowBlurMin,
          blurMax: _glowBlurMax,
          opacityMin: _glowOpacityMin,
          opacityMax: _glowOpacityMax,
          glowColor: _glowColor,
        );
      case _EffectType.ripple:
        return RippleEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          scaleMin: _rippleScaleMin,
          scaleMax: _rippleScaleMax,
          height: _rippleHeight,
          opacityMin: _rippleOpacityMin,
        );
      case _EffectType.spin:
        return SpinEffect(
          duration: Duration(milliseconds: _durationMs),
          delayBetweenChars: Duration(milliseconds: _delayMs),
          curve: _curve,
          spinCount: _spinCount,
          scaleFrom: _spinScaleFrom,
        );
      case _EffectType.flip:
        return FlipEffect(
          duration: Duration(milliseconds: _durationMs),
          delayBetweenChars: Duration(milliseconds: _delayMs),
          curve: _curve,
          flipCount: _flipCount,
          axis: _flipAxis,
        );
      case _EffectType.wiggle:
        return WiggleEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          amplitude: _wiggleAmplitude,
          frequency: _wiggleFrequency,
          rotationAmplitude: _wiggleRotationAmplitude,
        );
      case _EffectType.pulse:
        return PulseEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          scaleMin: _pulseScaleMin,
          scaleMax: _pulseScaleMax,
          opacityMin: _pulseOpacityMin,
        );
      case _EffectType.scatter:
        return ScatterEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          distance: _scatterDistance,
          delayBetweenChars: Duration(milliseconds: _delayMs),
        );
      case _EffectType.neonFlicker:
        return NeonFlickerEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          baseColor: _neonBaseColor,
          glowColor: _neonGlowColor,
          blurSigma: _neonBlurSigma,
          flickerSeed: _neonFlickerSeed,
        );
      case _EffectType.elastic:
        return ElasticEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          stretch: _elasticStretch,
          bounceCount: _elasticBounceCount,
          delayBetweenChars: Duration(milliseconds: _delayMs),
        );
      case _EffectType.highlight:
        return HighlightEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          highlightColor: _highlightColor,
          opacityFrom: _highlightOpacityFrom,
          opacityTo: _highlightOpacityTo,
          delayBetweenChars: Duration(milliseconds: _delayMs),
        );
      case _EffectType.underline:
        return UnderlineEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          lineColor: _underlineLineColor,
          height: _underlineHeight,
          delayBetweenChars: Duration(milliseconds: _delayMs),
        );
      case _EffectType.progressText:
        return ProgressTextEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          filledColor: _progressFilledColor,
          emptyColor: _progressEmptyColor,
        );
      case _EffectType.staggeredAppear:
        return StaggeredAppearEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          direction: _staggeredDirection,
          distance: _staggeredDistance,
          opacityFrom: _staggeredOpacityFrom,
          delayBetweenChars: Duration(milliseconds: _delayMs),
        );
      case _EffectType.fire:
        return FireEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          jitter: _fireJitter,
          blurSigma: _fireBlurSigma,
          maxScale: _fireMaxScale,
        );
      case _EffectType.smoke:
        return SmokeEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          height: _smokeHeight,
          blurSigma: _smokeBlurSigma,
          delayBetweenChars: Duration(milliseconds: _delayMs),
        );
      case _EffectType.vhsGlitch:
        return VHSGlitchEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          jitter: _vhsJitter,
          colorOffset: _vhsColorOffset,
          maxBlur: _vhsMaxBlur,
        );
      case _EffectType.reveal:
        return RevealEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          horizontal: _revealHorizontal,
          delayBetweenChars: Duration(milliseconds: _delayMs),
        );
      case _EffectType.liquid:
        return LiquidEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          amplitude: _liquidAmplitude,
          frequency: _liquidFrequency,
          waveHeight: _liquidWaveHeight,
        );
      case _EffectType.scanner:
        return ScannerEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          scanColor: _scannerColor,
          scanWidth: _scannerScanWidth,
          glowWidth: _scannerGlowWidth,
        );
      case _EffectType.waveColor:
        return WaveColorEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          colorA: _waveColorA,
          colorB: _waveColorB,
          waveCount: _waveColorCount,
        );
      case _EffectType.breathingOpacity:
        return BreathingOpacityEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          opacityMin: _breathingOpacityMin,
        );
      case _EffectType.conveyorBelt:
        return ConveyorBeltEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          spacing: _conveyorSpacing,
          reverse: _conveyorReverse,
        );
      case _EffectType.meltDrip:
        return MeltDripEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          meltAmount: _meltAmount,
          dripHeight: _meltDripHeight,
          blurSigma: _meltBlurSigma,
          delayBetweenChars: Duration(milliseconds: _delayMs),
        );
      case _EffectType.sparkleTwinkle:
        return SparkleTwinkleEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          sparkleColor: _sparkleColor,
          sparkleScale: _sparkleScale,
          sparkleBlur: _sparkleBlur,
        );
      case _EffectType.matrixRain:
        return MatrixRainEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          matrixGreen: _matrixGreen,
          fallSpeed: _matrixFallSpeed,
          blurSigma: _matrixBlurSigma,
        );
      case _EffectType.glitchSplit:
        return GlitchSplitEffect(
          duration: Duration(milliseconds: _durationMs),
          curve: _curve,
          splitAmount: _glitchSplitAmount,
          probability: _glitchProbability,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final effects = _buildEffects();

    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: AnimatedText(
                _text,
                effects: effects,
                repeat: _repeat,
                reverse: _reverse,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(height: 24),
          _section('Text'),
          TextField(
            controller: _textController,
            onChanged: (v) => setState(() => _text = v),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          const SizedBox(height: 16),
          _section('Duration'),
          _slider(
            value: _durationMs.toDouble(),
            min: 100, max: 5000, divisions: 49,
            label: '${_durationMs}ms',
            onChanged: (v) => setState(() => _durationMs = v.round()),
          ),
          const SizedBox(height: 8),
          _section('Delay between chars'),
          _slider(
            value: _delayMs.toDouble(),
            min: 0, max: 500, divisions: 50,
            label: '${_delayMs}ms',
            onChanged: (v) => setState(() => _delayMs = v.round()),
          ),
          const SizedBox(height: 8),
          _section('Curve'),
          DropdownButtonFormField<Curve>(
            value: _curve,
            items: _curveOptions.map((c) {
              return DropdownMenuItem(
                value: c,
                child: Text(c.toString()),
              );
            }).toList(),
            onChanged: (v) {
              if (v != null) setState(() => _curve = v);
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: _repeat,
                onChanged: (v) => setState(() => _repeat = v ?? false),
              ),
              const Text('Repeat'),
              const SizedBox(width: 24),
              Checkbox(
                value: _reverse,
                onChanged: _repeat
                    ? (v) => setState(() => _reverse = v ?? false)
                    : null,
              ),
              const Text('Reverse'),
            ],
          ),
          const Divider(),
          _section('Effects (check to enable)'),
          const SizedBox(height: 4),
          ..._EffectType.values.map((type) {
            final enabled = _enabledEffects.contains(type);
            return Column(
              children: [
                CheckboxListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  title: Text(_effectLabels[type]!),
                  value: enabled,
                  onChanged: (v) {
                    setState(() {
                      if (v == true) {
                        _enabledEffects.add(type);
                      } else {
                        _enabledEffects.remove(type);
                      }
                    });
                  },
                ),
                if (enabled)
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: _buildEffectControls(type),
                  ),
              ],
            );
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildEffectControls(_EffectType type) {
    switch (type) {
      case _EffectType.fade:
        return Column(
          children: [
            _section('Opacity From'),
            _slider(value: _fadeOpacityFrom, min: 0, max: 1, label: _fadeOpacityFrom.toStringAsFixed(2), onChanged: (v) => setState(() => _fadeOpacityFrom = v)),
            _section('Opacity To'),
            _slider(value: _fadeOpacityTo, min: 0, max: 1, label: _fadeOpacityTo.toStringAsFixed(2), onChanged: (v) => setState(() => _fadeOpacityTo = v)),
          ],
        );
      case _EffectType.gradient:
        return Column(
          children: [
            for (int i = 0; i < _gradientColors.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: Text('Color ${i + 1}')),
                    _colorSwatches(
                      selected: _gradientColors[i],
                      onSelected: (c) => setState(() {
                        final list = [..._gradientColors];
                        list[i] = c;
                        _gradientColors = list;
                      }),
                    ),
                  ],
                ),
              ),
            TextButton.icon(
              onPressed: _gradientColors.length < 5
                  ? () => setState(() => _gradientColors = [..._gradientColors, Colors.white])
                  : null,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add color'),
            ),
            if (_gradientColors.length > 2)
              TextButton.icon(
                onPressed: () => setState(() => _gradientColors = _gradientColors.sublist(0, _gradientColors.length - 1)),
                icon: const Icon(Icons.remove, size: 18),
                label: const Text('Remove color'),
              ),
          ],
        );
      case _EffectType.wave:
        return Column(
          children: [
            _section('Scale Min'), _slider(value: _waveScaleMin, min: 0, max: 3, label: _waveScaleMin.toStringAsFixed(2), onChanged: (v) => setState(() => _waveScaleMin = v)),
            _section('Scale Max'), _slider(value: _waveScaleMax, min: 0, max: 3, label: _waveScaleMax.toStringAsFixed(2), onChanged: (v) => setState(() => _waveScaleMax = v)),
            _section('Wave Count'), _slider(value: _waveCount.toDouble(), min: 1, max: 10, divisions: 9, label: '$_waveCount', onChanged: (v) => setState(() => _waveCount = v.round())),
          ],
        );
      case _EffectType.typewriter:
        return Column(
          children: [
            _section('Cursor'),
            TextField(
              controller: _cursorController,
              onChanged: (v) => setState(() => _typewriterCursor = v),
              decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
            ),
            const SizedBox(height: 8),
            _section('Cursor Color'),
            _colorSwatches(selected: _typewriterCursorColor ?? Colors.transparent, onSelected: (c) => setState(() => _typewriterCursorColor = c), allowNone: true),
          ],
        );
      case _EffectType.bounce:
        return Column(
          children: [
            _section('Height'), _slider(value: _bounceHeight, min: 0, max: 100, label: '${_bounceHeight.round()}', onChanged: (v) => setState(() => _bounceHeight = v)),
            _section('Bounce Count'), _slider(value: _bounceCount.toDouble(), min: 1, max: 10, divisions: 9, label: '$_bounceCount', onChanged: (v) => setState(() => _bounceCount = v.round())),
          ],
        );
      case _EffectType.shimmer:
        return Column(
          children: [
            _section('Base Color'), _colorSwatches(selected: _shimmerBase, onSelected: (c) => setState(() => _shimmerBase = c)),
            _section('Highlight Color'), _colorSwatches(selected: _shimmerHighlight, onSelected: (c) => setState(() => _shimmerHighlight = c)),
            _section('Width'), _slider(value: _shimmerWidth, min: 0.05, max: 1, label: _shimmerWidth.toStringAsFixed(2), onChanged: (v) => setState(() => _shimmerWidth = v)),
          ],
        );
      case _EffectType.slide:
        return Column(
          children: [
            _section('Direction'),
            DropdownButtonFormField<SlideDirection>(
              value: _slideDirection,
              items: SlideDirection.values.map((d) => DropdownMenuItem(value: d, child: Text(d.name))).toList(),
              onChanged: (v) { if (v != null) setState(() => _slideDirection = v); },
            ),
            _section('Distance'), _slider(value: _slideDistance, min: 0, max: 300, label: '${_slideDistance.round()}', onChanged: (v) => setState(() => _slideDistance = v)),
          ],
        );
      case _EffectType.blur:
        return Column(
          children: [
            _section('Sigma From'), _slider(value: _blurSigmaFrom, min: 0, max: 30, divisions: 30, label: _blurSigmaFrom.toStringAsFixed(1), onChanged: (v) => setState(() => _blurSigmaFrom = v)),
            _section('Sigma To'), _slider(value: _blurSigmaTo, min: 0, max: 30, divisions: 30, label: _blurSigmaTo.toStringAsFixed(1), onChanged: (v) => setState(() => _blurSigmaTo = v)),
          ],
        );
      case _EffectType.rainbow:
        return Column(
          children: [
            _section('Saturation'), _slider(value: _rainbowSaturation, min: 0, max: 1, label: _rainbowSaturation.toStringAsFixed(2), onChanged: (v) => setState(() => _rainbowSaturation = v)),
            _section('Lightness'), _slider(value: _rainbowLightness, min: 0, max: 1, label: _rainbowLightness.toStringAsFixed(2), onChanged: (v) => setState(() => _rainbowLightness = v)),
            _section('Cycle Count'), _slider(value: _rainbowCycleCount.toDouble(), min: 1, max: 5, divisions: 4, label: '$_rainbowCycleCount', onChanged: (v) => setState(() => _rainbowCycleCount = v.round())),
          ],
        );
      case _EffectType.glow:
        return Column(
          children: [
            _section('Blur Min'), _slider(value: _glowBlurMin, min: 0, max: 30, label: _glowBlurMin.toStringAsFixed(1), onChanged: (v) => setState(() => _glowBlurMin = v)),
            _section('Blur Max'), _slider(value: _glowBlurMax, min: 0, max: 30, label: _glowBlurMax.toStringAsFixed(1), onChanged: (v) => setState(() => _glowBlurMax = v)),
            _section('Opacity Min'), _slider(value: _glowOpacityMin, min: 0, max: 1, label: _glowOpacityMin.toStringAsFixed(2), onChanged: (v) => setState(() => _glowOpacityMin = v)),
            _section('Opacity Max'), _slider(value: _glowOpacityMax, min: 0, max: 1, label: _glowOpacityMax.toStringAsFixed(2), onChanged: (v) => setState(() => _glowOpacityMax = v)),
            _section('Glow Color'), _colorSwatches(selected: _glowColor ?? Colors.transparent, onSelected: (c) => setState(() => _glowColor = c), allowNone: true),
          ],
        );
      case _EffectType.ripple:
        return Column(
          children: [
            _section('Scale Min'), _slider(value: _rippleScaleMin, min: 0, max: 3, label: _rippleScaleMin.toStringAsFixed(2), onChanged: (v) => setState(() => _rippleScaleMin = v)),
            _section('Scale Max'), _slider(value: _rippleScaleMax, min: 0, max: 3, label: _rippleScaleMax.toStringAsFixed(2), onChanged: (v) => setState(() => _rippleScaleMax = v)),
            _section('Height'), _slider(value: _rippleHeight, min: 0, max: 100, label: '${_rippleHeight.round()}', onChanged: (v) => setState(() => _rippleHeight = v)),
            _section('Opacity Min'), _slider(value: _rippleOpacityMin, min: 0, max: 1, label: _rippleOpacityMin.toStringAsFixed(2), onChanged: (v) => setState(() => _rippleOpacityMin = v)),
          ],
        );
      case _EffectType.spin:
        return Column(
          children: [
            _section('Spin Count'), _slider(value: _spinCount.toDouble(), min: 1, max: 10, divisions: 9, label: '$_spinCount', onChanged: (v) => setState(() => _spinCount = v.round())),
            _section('Scale From'), _slider(value: _spinScaleFrom, min: 0, max: 1, label: _spinScaleFrom.toStringAsFixed(2), onChanged: (v) => setState(() => _spinScaleFrom = v)),
          ],
        );
      case _EffectType.flip:
        return Column(
          children: [
            _section('Flip Count'), _slider(value: _flipCount.toDouble(), min: 1, max: 10, divisions: 9, label: '$_flipCount', onChanged: (v) => setState(() => _flipCount = v.round())),
            const SizedBox(height: 8),
            Row(children: [const Text('X axis'), Switch(value: _flipAxis, onChanged: (v) => setState(() => _flipAxis = v)), const Text('Y axis')]),
          ],
        );
      case _EffectType.wiggle:
        return Column(
          children: [
            _section('Amplitude'), _slider(value: _wiggleAmplitude, min: 0, max: 20, label: _wiggleAmplitude.toStringAsFixed(1), onChanged: (v) => setState(() => _wiggleAmplitude = v)),
            _section('Frequency'), _slider(value: _wiggleFrequency, min: 0.5, max: 10, label: _wiggleFrequency.toStringAsFixed(1), onChanged: (v) => setState(() => _wiggleFrequency = v)),
            _section('Rotation'), _slider(value: _wiggleRotationAmplitude, min: 0, max: 0.3, label: _wiggleRotationAmplitude.toStringAsFixed(2), onChanged: (v) => setState(() => _wiggleRotationAmplitude = v)),
          ],
        );
      case _EffectType.pulse:
        return Column(
          children: [
            _section('Scale Min'), _slider(value: _pulseScaleMin, min: 0.5, max: 2, label: _pulseScaleMin.toStringAsFixed(2), onChanged: (v) => setState(() => _pulseScaleMin = v)),
            _section('Scale Max'), _slider(value: _pulseScaleMax, min: 0.5, max: 2, label: _pulseScaleMax.toStringAsFixed(2), onChanged: (v) => setState(() => _pulseScaleMax = v)),
            _section('Opacity Min'), _slider(value: _pulseOpacityMin, min: 0, max: 1, label: _pulseOpacityMin.toStringAsFixed(2), onChanged: (v) => setState(() => _pulseOpacityMin = v)),
          ],
        );
      case _EffectType.scatter:
        return Column(
          children: [
            _section('Distance'), _slider(value: _scatterDistance, min: 20, max: 400, label: '${_scatterDistance.round()}', onChanged: (v) => setState(() => _scatterDistance = v)),
          ],
        );
      case _EffectType.neonFlicker:
        return Column(
          children: [
            _section('Base Color'), _colorSwatches(selected: _neonBaseColor, onSelected: (c) => setState(() => _neonBaseColor = c)),
            _section('Glow Color'), _colorSwatches(selected: _neonGlowColor, onSelected: (c) => setState(() => _neonGlowColor = c)),
            _section('Blur Sigma'), _slider(value: _neonBlurSigma, min: 0, max: 20, label: _neonBlurSigma.toStringAsFixed(1), onChanged: (v) => setState(() => _neonBlurSigma = v)),
          ],
        );
      case _EffectType.elastic:
        return Column(
          children: [
            _section('Stretch'), _slider(value: _elasticStretch, min: 0, max: 1, label: _elasticStretch.toStringAsFixed(2), onChanged: (v) => setState(() => _elasticStretch = v)),
            _section('Bounce Count'), _slider(value: _elasticBounceCount.toDouble(), min: 1, max: 5, divisions: 4, label: '$_elasticBounceCount', onChanged: (v) => setState(() => _elasticBounceCount = v.round())),
          ],
        );
      case _EffectType.highlight:
        return Column(
          children: [
            _section('Highlight Color'), _colorSwatches(selected: _highlightColor, onSelected: (c) => setState(() => _highlightColor = c)),
            _section('Opacity From'), _slider(value: _highlightOpacityFrom, min: 0, max: 1, label: _highlightOpacityFrom.toStringAsFixed(2), onChanged: (v) => setState(() => _highlightOpacityFrom = v)),
            _section('Opacity To'), _slider(value: _highlightOpacityTo, min: 0, max: 1, label: _highlightOpacityTo.toStringAsFixed(2), onChanged: (v) => setState(() => _highlightOpacityTo = v)),
          ],
        );
      case _EffectType.underline:
        return Column(
          children: [
            _section('Line Color'), _colorSwatches(selected: _underlineLineColor, onSelected: (c) => setState(() => _underlineLineColor = c)),
            _section('Line Height'), _slider(value: _underlineHeight, min: 0.5, max: 8, label: _underlineHeight.toStringAsFixed(1), onChanged: (v) => setState(() => _underlineHeight = v)),
          ],
        );
      case _EffectType.progressText:
        return Column(
          children: [
            _section('Filled Color'), _colorSwatches(selected: _progressFilledColor, onSelected: (c) => setState(() => _progressFilledColor = c)),
            _section('Empty Color'), _colorSwatches(selected: _progressEmptyColor, onSelected: (c) => setState(() => _progressEmptyColor = c)),
          ],
        );
      case _EffectType.staggeredAppear:
        return Column(
          children: [
            _section('Direction'),
            DropdownButtonFormField<SlideDirection>(
              value: _staggeredDirection,
              items: SlideDirection.values.map((d) => DropdownMenuItem(value: d, child: Text(d.name))).toList(),
              onChanged: (v) { if (v != null) setState(() => _staggeredDirection = v); },
            ),
            _section('Distance'), _slider(value: _staggeredDistance, min: 0, max: 150, label: '${_staggeredDistance.round()}', onChanged: (v) => setState(() => _staggeredDistance = v)),
            _section('Opacity From'), _slider(value: _staggeredOpacityFrom, min: 0, max: 1, label: _staggeredOpacityFrom.toStringAsFixed(2), onChanged: (v) => setState(() => _staggeredOpacityFrom = v)),
          ],
        );
      case _EffectType.fire:
        return Column(
          children: [
            _section('Jitter'), _slider(value: _fireJitter, min: 0, max: 10, label: _fireJitter.toStringAsFixed(1), onChanged: (v) => setState(() => _fireJitter = v)),
            _section('Blur Sigma'), _slider(value: _fireBlurSigma, min: 0, max: 15, label: _fireBlurSigma.toStringAsFixed(1), onChanged: (v) => setState(() => _fireBlurSigma = v)),
            _section('Max Scale'), _slider(value: _fireMaxScale, min: 1, max: 2, label: _fireMaxScale.toStringAsFixed(2), onChanged: (v) => setState(() => _fireMaxScale = v)),
          ],
        );
      case _EffectType.smoke:
        return Column(
          children: [
            _section('Height'), _slider(value: _smokeHeight, min: 10, max: 150, label: '${_smokeHeight.round()}', onChanged: (v) => setState(() => _smokeHeight = v)),
            _section('Blur Sigma'), _slider(value: _smokeBlurSigma, min: 0, max: 20, label: _smokeBlurSigma.toStringAsFixed(1), onChanged: (v) => setState(() => _smokeBlurSigma = v)),
          ],
        );
      case _EffectType.vhsGlitch:
        return Column(
          children: [
            _section('Jitter'), _slider(value: _vhsJitter, min: 0, max: 30, label: _vhsJitter.toStringAsFixed(1), onChanged: (v) => setState(() => _vhsJitter = v)),
            _section('Color Offset'), _slider(value: _vhsColorOffset, min: 0, max: 20, label: _vhsColorOffset.toStringAsFixed(1), onChanged: (v) => setState(() => _vhsColorOffset = v)),
            _section('Max Blur'), _slider(value: _vhsMaxBlur, min: 0, max: 5, label: _vhsMaxBlur.toStringAsFixed(1), onChanged: (v) => setState(() => _vhsMaxBlur = v)),
          ],
        );
      case _EffectType.reveal:
        return Column(
          children: [
            Row(children: [const Text('Horizontal'), Switch(value: _revealHorizontal, onChanged: (v) => setState(() => _revealHorizontal = v)), const Text('Vertical')]),
          ],
        );
      case _EffectType.liquid:
        return Column(
          children: [
            _section('Amplitude'), _slider(value: _liquidAmplitude, min: 0, max: 1, label: _liquidAmplitude.toStringAsFixed(2), onChanged: (v) => setState(() => _liquidAmplitude = v)),
            _section('Frequency'), _slider(value: _liquidFrequency, min: 0.5, max: 5, label: _liquidFrequency.toStringAsFixed(1), onChanged: (v) => setState(() => _liquidFrequency = v)),
            _section('Wave Height'), _slider(value: _liquidWaveHeight, min: 0, max: 20, label: _liquidWaveHeight.toStringAsFixed(1), onChanged: (v) => setState(() => _liquidWaveHeight = v)),
          ],
        );
      case _EffectType.scanner:
        return Column(
          children: [
            _section('Scan Color'), _colorSwatches(selected: _scannerColor, onSelected: (c) => setState(() => _scannerColor = c)),
            _section('Scan Width'), _slider(value: _scannerScanWidth, min: 0.05, max: 0.5, label: _scannerScanWidth.toStringAsFixed(2), onChanged: (v) => setState(() => _scannerScanWidth = v)),
            _section('Glow Width'), _slider(value: _scannerGlowWidth, min: 0.1, max: 1, label: _scannerGlowWidth.toStringAsFixed(2), onChanged: (v) => setState(() => _scannerGlowWidth = v)),
          ],
        );
      case _EffectType.waveColor:
        return Column(
          children: [
            _section('Color A'), _colorSwatches(selected: _waveColorA, onSelected: (c) => setState(() => _waveColorA = c)),
            _section('Color B'), _colorSwatches(selected: _waveColorB, onSelected: (c) => setState(() => _waveColorB = c)),
            _section('Wave Count'), _slider(value: _waveColorCount.toDouble(), min: 1, max: 10, divisions: 9, label: '$_waveColorCount', onChanged: (v) => setState(() => _waveColorCount = v.round())),
          ],
        );
      case _EffectType.breathingOpacity:
        return Column(
          children: [
            _section('Opacity Min'), _slider(value: _breathingOpacityMin, min: 0, max: 1, label: _breathingOpacityMin.toStringAsFixed(2), onChanged: (v) => setState(() => _breathingOpacityMin = v)),
          ],
        );
      case _EffectType.conveyorBelt:
        return Column(
          children: [
            _section('Spacing'), _slider(value: _conveyorSpacing, min: 5, max: 100, label: '${_conveyorSpacing.round()}', onChanged: (v) => setState(() => _conveyorSpacing = v)),
            Row(children: [const Text('Reverse'), Switch(value: _conveyorReverse, onChanged: (v) => setState(() => _conveyorReverse = v))]),
          ],
        );
      case _EffectType.meltDrip:
        return Column(
          children: [
            _section('Melt Amount'), _slider(value: _meltAmount, min: 0, max: 1, label: _meltAmount.toStringAsFixed(2), onChanged: (v) => setState(() => _meltAmount = v)),
            _section('Drip Height'), _slider(value: _meltDripHeight, min: 10, max: 150, label: '${_meltDripHeight.round()}', onChanged: (v) => setState(() => _meltDripHeight = v)),
            _section('Blur Sigma'), _slider(value: _meltBlurSigma, min: 0, max: 15, label: _meltBlurSigma.toStringAsFixed(1), onChanged: (v) => setState(() => _meltBlurSigma = v)),
          ],
        );
      case _EffectType.sparkleTwinkle:
        return Column(
          children: [
            _section('Sparkle Color'), _colorSwatches(selected: _sparkleColor, onSelected: (c) => setState(() => _sparkleColor = c)),
            _section('Sparkle Scale'), _slider(value: _sparkleScale, min: 1, max: 2.5, label: _sparkleScale.toStringAsFixed(2), onChanged: (v) => setState(() => _sparkleScale = v)),
            _section('Sparkle Blur'), _slider(value: _sparkleBlur, min: 0, max: 15, label: _sparkleBlur.toStringAsFixed(1), onChanged: (v) => setState(() => _sparkleBlur = v)),
          ],
        );
      case _EffectType.matrixRain:
        return Column(
          children: [
            _section('Matrix Green'), _colorSwatches(selected: _matrixGreen, onSelected: (c) => setState(() => _matrixGreen = c)),
            _section('Fall Speed'), _slider(value: _matrixFallSpeed, min: 0.2, max: 3, label: _matrixFallSpeed.toStringAsFixed(1), onChanged: (v) => setState(() => _matrixFallSpeed = v)),
            _section('Blur Sigma'), _slider(value: _matrixBlurSigma, min: 0, max: 10, label: _matrixBlurSigma.toStringAsFixed(1), onChanged: (v) => setState(() => _matrixBlurSigma = v)),
          ],
        );
      case _EffectType.glitchSplit:
        return Column(
          children: [
            _section('Split Amount'), _slider(value: _glitchSplitAmount, min: 1, max: 20, label: _glitchSplitAmount.toStringAsFixed(1), onChanged: (v) => setState(() => _glitchSplitAmount = v)),
            _section('Probability'), _slider(value: _glitchProbability, min: 0, max: 1, label: _glitchProbability.toStringAsFixed(2), onChanged: (v) => setState(() => _glitchProbability = v)),
          ],
        );
    }
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 4),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
    );
  }

  Widget _slider({required double value, required double min, required double max, int? divisions, required String label, required ValueChanged<double> onChanged}) {
    return Slider(value: value.clamp(min, max), min: min, max: max, divisions: divisions, label: label, onChanged: onChanged);
  }

  Widget _colorSwatches({required Color selected, required ValueChanged<Color> onSelected, bool allowNone = false}) {
    return Wrap(
      spacing: 6, runSpacing: 6,
      children: [
        if (allowNone)
          GestureDetector(
            onTap: () => onSelected(Colors.transparent),
            child: Container(
              width: 28, height: 28,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey), color: Colors.transparent),
              child: const Icon(Icons.close, size: 16, color: Colors.grey),
            ),
          ),
        for (final c in _colorOptions)
          GestureDetector(
            onTap: () => onSelected(c),
            child: Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: selected == c ? Colors.white : Colors.grey.shade700, width: selected == c ? 2.5 : 1),
                color: c,
              ),
            ),
          ),
      ],
    );
  }
}
