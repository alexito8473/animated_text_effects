import 'package:flutter/material.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

// ──────────────────────────────────────────────────────────────
// Shared helpers
// ──────────────────────────────────────────────────────────────

const List<TextEffect Function()> _effectFactories = [
  FadeEffect.new,
  SlideEffect.new,
  BlurEffect.new,
  WaveEffect.new,
  TypewriterEffect.new,
  BounceEffect.new,
  StaggeredAppearEffect.new,
  ElasticEffect.new,
  PopInEffect.new,
  RandomRevealEffect.new,
  ScatterEffect.new,
  TrackingEffect.new,
  GlowRevealEffect.new,
  KineticTypeEffect.new,
  SplitRevealEffect.new,
  InkDropsEffect.new,
  ChromaticAberrationEffect.new,
  PixelateEffect.new,
  WaterRippleEffect.new,
  VortexEffect.new,
  CascadeEffect.new,
  OrigamiEffect.new,
  ShatterEffect.new,
  MorphEffect.new,
  CurtainEffect.new,
  StompEffect.new,
  TypewriterErrorEffect.new,
  TypewriterDeleteEffect.new,
  FallingLeavesEffect.new,
  FirefliesEffect.new,
  BreathEffect.new,
  CircularRevealEffect.new,
  ScanLinesEffect.new,
  BarWakeEffect.new,
  WeightEffect.new,
  CountdownEffect.new,
];

const List<String> _effectNames = [
  'Fade',
  'Slide',
  'Blur',
  'Wave',
  'Typewriter',
  'Bounce',
  'Staggered',
  'Elastic',
  'PopIn',
  'Random',
  'Scatter',
  'Tracking',
  'GlowReveal',
  'Kinetic',
  'Split',
  'InkDrops',
  'ChromaticAb.',
  'Pixelate',
  'WaterRipple',
  'Vortex',
  'Cascade',
  'Origami',
  'Shatter',
  'Morph',
  'Curtain',
  'Stomp',
  'TypError',
  'TypDelete',
  'FallingLeaves',
  'Fireflies',
  'Breath',
  'CircReveal',
  'ScanLines',
  'BarWake',
  'Weight',
  'Countdown',
];

const _colorOptions = [
  Colors.white,
  Colors.grey,
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

const _curveOptions = [
  Curves.linear,
  Curves.easeInOut,
  Curves.easeIn,
  Curves.easeOut,
  Curves.bounceOut,
  Curves.elasticOut,
];

Widget _section(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 4),
    child: Text(
      title,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
    ),
  );
}

Widget _slider({
  required double value,
  required double min,
  required double max,
  int? divisions,
  required String label,
  required ValueChanged<double> onChanged,
}) {
  return Slider(
    value: value.clamp(min, max),
    min: min,
    max: max,
    divisions: divisions,
    label: label,
    onChanged: onChanged,
  );
}

Widget _colorSwatches({required Color selected, required ValueChanged<Color> onSelected, bool allowNone = false}) {
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: [
      if (allowNone)
        GestureDetector(
          onTap: () => onSelected(Colors.transparent),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: Colors.transparent,
            ),
            child: const Icon(Icons.close, size: 16, color: Colors.grey),
          ),
        ),
      for (final c in _colorOptions)
        GestureDetector(
          onTap: () => onSelected(c),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected == c ? Colors.white : Colors.grey.shade700,
                width: selected == c ? 2.5 : 1,
              ),
              color: c,
            ),
          ),
        ),
    ],
  );
}

// ──────────────────────────────────────────────────────────────
// Comprehensive Demo — 3 versions
// ──────────────────────────────────────────────────────────────

class ComprehensiveDemo extends StatefulWidget {
  const ComprehensiveDemo({super.key});

  @override
  State<ComprehensiveDemo> createState() => _ComprehensiveDemoState();
}

class _ComprehensiveDemoState extends State<ComprehensiveDemo>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comprehensive Demo')),
      body: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'Static Text'),
              Tab(text: 'Sequence'),
              Tab(text: 'Mixed'),
            ],
            controller: _tabController,
          ),
          Expanded(
            child: IndexedStack(
              index: _tabController.index,
              children: const [
                _StaticTextTab(),
                _SequenceTab(),
                _MixedTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// TAB 1 — Static Text (Múltiples textos con controles)
// ──────────────────────────────────────────────────────────────

class _StaticTextTab extends StatefulWidget {
  const _StaticTextTab();

  @override
  State<_StaticTextTab> createState() => _StaticTextTabState();
}

class _StaticTextTabState extends State<_StaticTextTab> {
  final _textController = TextEditingController(text: 'Hello World');
  String _text = 'Hello World';

  int _effectIndex = 0;
  int _durationMs = 1500;
  int _delayMs = 50;
  int _curveIndex = 1;
  bool _repeat = true;
  bool _reverse = false;
  Color _color = Colors.white;
  double _fontSize = 28;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effect = _effectFactories[_effectIndex]();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Preview
        Container(
          height: 100,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: AnimatedText(
            _text,
            effects: [effect],
            repeat: _repeat,
            reverse: _reverse,
            style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold, color: _color),
          ),
        ),

        _section('Text'),
        TextField(
          controller: _textController,
          onChanged: (v) => setState(() => _text = v),
          decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
        ),
        const SizedBox(height: 12),

        _section('Effect'),
        DropdownButtonFormField<int>(
          value: _effectIndex,
          items: List.generate(_effectNames.length, (i) {
            return DropdownMenuItem(value: i, child: Text(_effectNames[i]));
          }),
          onChanged: (v) {
            if (v != null) setState(() => _effectIndex = v);
          },
        ),
        const SizedBox(height: 12),

        _section('Duration (ms)'),
        _slider(value: _durationMs.toDouble(), min: 200, max: 5000, divisions: 24, label: '${_durationMs}ms', onChanged: (v) => setState(() => _durationMs = v.round())),
        const SizedBox(height: 8),

        _section('Delay between chars (ms)'),
        _slider(value: _delayMs.toDouble(), min: 0, max: 300, divisions: 30, label: '${_delayMs}ms', onChanged: (v) => setState(() => _delayMs = v.round())),
        const SizedBox(height: 8),

        _section('Curve'),
        DropdownButtonFormField<int>(
          value: _curveIndex,
          items: List.generate(_curveOptions.length, (i) {
            return DropdownMenuItem(value: i, child: Text(_curveOptions[i].toString()));
          }),
          onChanged: (v) {
            if (v != null) setState(() => _curveIndex = v);
          },
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Checkbox(value: _repeat, onChanged: (v) => setState(() => _repeat = v ?? false)),
            const Text('Repeat'),
            const SizedBox(width: 24),
            Checkbox(value: _reverse, onChanged: _repeat ? (v) => setState(() => _reverse = v ?? false) : null),
            const Text('Reverse'),
          ],
        ),
        const SizedBox(height: 8),

        _section('Font Size'),
        _slider(value: _fontSize, min: 12, max: 64, divisions: 52, label: '${_fontSize.round()}', onChanged: (v) => setState(() => _fontSize = v)),
        const SizedBox(height: 8),

        _section('Color'),
        _colorSwatches(selected: _color, onSelected: (c) => setState(() => _color = c)),
        const SizedBox(height: 24),

        // Show more static examples
        const Text('More examples:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _staticMiniPreview('Typewriter', const [TypewriterEffect(delayBetweenChars: Duration(milliseconds: 60))]),
        _staticMiniPreview('Bounce', const [BounceEffect(delayBetweenChars: Duration(milliseconds: 40))]),
        _staticMiniPreview('PopIn', const [PopInEffect(delayBetweenChars: Duration(milliseconds: 50))]),
        _staticMiniPreview('Elastic', const [ElasticEffect(delayBetweenChars: Duration(milliseconds: 40))]),
        _staticMiniPreview('RandomReveal', const [RandomRevealEffect()]),
        _staticMiniPreview('Tracking', const [TrackingEffect()]),
        _staticMiniPreview('GlowReveal', const [GlowRevealEffect()]),
        _staticMiniPreview('KineticType', const [KineticTypeEffect()]),
        _staticMiniPreview('SplitReveal', const [SplitRevealEffect()]),
        _staticMiniPreview('InkDrops', const [InkDropsEffect()]),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _staticMiniPreview(String label, List<TextEffect> effects) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey))),
          Expanded(
            child: AnimatedText(
              label,
              effects: effects,
              repeat: true,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// TAB 2 — Sequence (Secuencia con múltiples textos
//          y controles individuales + gap)
// ──────────────────────────────────────────────────────────────

class _SequenceTab extends StatefulWidget {
  const _SequenceTab();

  @override
  State<_SequenceTab> createState() => _SequenceTabState();
}

class _SequenceTabState extends State<_SequenceTab> {
  final _textControllers = List.generate(6, (_) => TextEditingController());

  final List<String> _texts = [
    'Hello Sequence!',
    'Next Text Here',
    'Third Text',
    'Fourth One',
    'Fifth Line',
    'Sixth Text',
  ];

  final List<int> _effectIndices = [0, 1, 2, 0, 1, 2];

  int _textCount = 3;
  int _transitionEffectIndex = 0;
  int _displayDurationMs = 3000;
  int _transitionDurationMs = 600;
  bool _repeat = true;
  Color _color = Colors.white;

  bool _enableGap = false;
  final _gapController = TextEditingController(text: ' • ');

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _texts.length; i++) {
      _textControllers[i].text = _texts[i];
    }
  }

  @override
  void dispose() {
    _gapController.dispose();
    for (final c in _textControllers) {
      c.dispose();
    }
    super.dispose();
  }

  SequenceText _buildSequenceText(int i) {
    return SequenceText(
      _textControllers[i].text,
      effects: [
        _effectFactories[_effectIndices[i]](),
      ],
    );
  }

  List<SequenceText> _buildTexts() {
    final result = <SequenceText>[];
    final count = _textCount;
    for (int i = 0; i < count; i++) {
      result.add(_buildSequenceText(i));
      if (_enableGap && i < count - 1) {
        result.add(SequenceText(_gapController.text, effects: const []));
      }
    }
    return result;
  }

  TextEffect? get _transitionEffect {
    if (_transitionEffectIndex < _effectFactories.length) {
      return _effectFactories[_transitionEffectIndex]();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final texts = _buildTexts();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Preview
        Container(
          height: 80,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: AnimatedTextSequence(
            texts: texts,
            repeat: _repeat,
            transitionEffect: _transitionEffect,
            displayDuration: Duration(milliseconds: _displayDurationMs),
            transitionDuration: Duration(milliseconds: _transitionDurationMs),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _color),
          ),
        ),

        _section('Number of texts'),
        _slider(
          value: _textCount.toDouble(),
          min: 2,
          max: 6,
          divisions: 4,
          label: '$_textCount',
          onChanged: (v) => setState(() => _textCount = v.round()),
        ),
        const SizedBox(height: 12),

        _section('Gap between texts'),
        SwitchListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          title: const Text('Enable gap'),
          value: _enableGap,
          onChanged: (v) => setState(() => _enableGap = v),
        ),
        if (_enableGap)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextField(
              controller: _gapController,
              decoration: const InputDecoration(
                labelText: 'Gap text',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),

        _section('Display Duration (ms)'),
        _slider(
          value: _displayDurationMs.toDouble(),
          min: 500,
          max: 8000,
          divisions: 15,
          label: '${_displayDurationMs}ms',
          onChanged: (v) => setState(() => _displayDurationMs = v.round()),
        ),
        const SizedBox(height: 8),

        _section('Transition Duration (ms)'),
        _slider(
          value: _transitionDurationMs.toDouble(),
          min: 100,
          max: 2000,
          divisions: 19,
          label: '${_transitionDurationMs}ms',
          onChanged: (v) => setState(() => _transitionDurationMs = v.round()),
        ),
        const SizedBox(height: 8),

        _section('Transition Effect'),
        DropdownButtonFormField<int>(
          value: _transitionEffectIndex,
          items: [
            const DropdownMenuItem(value: -1, child: Text('Cross-fade (none)')),
            ...List.generate(_effectNames.length, (i) {
              return DropdownMenuItem(value: i, child: Text(_effectNames[i]));
            }),
          ],
          onChanged: (v) {
            if (v != null) setState(() => _transitionEffectIndex = v);
          },
        ),
        const SizedBox(height: 8),

        SwitchListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          title: const Text('Repeat'),
          value: _repeat,
          onChanged: (v) => setState(() => _repeat = v),
        ),
        const SizedBox(height: 8),

        _section('Color'),
        _colorSwatches(selected: _color, onSelected: (c) => setState(() => _color = c)),
        const SizedBox(height: 16),

        // Per-text configuration
        const Text('Per-text settings:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...List.generate(_textCount, (i) {
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Text ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _textControllers[i],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    value: _effectIndices[i],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                    items: List.generate(_effectNames.length, (j) {
                      return DropdownMenuItem(value: j, child: Text(_effectNames[j]));
                    }),
                    onChanged: (v) {
                      if (v != null) setState(() => _effectIndices[i] = v);
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 40),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────
// TAB 3 — Mixed: texto estático + secuencia inline sobre
//          una misma palabra/frase
// ──────────────────────────────────────────────────────────────

class _MixedTab extends StatefulWidget {
  const _MixedTab();

  @override
  State<_MixedTab> createState() => _MixedTabState();
}

class _MixedTabState extends State<_MixedTab> {
  final _prefixController = TextEditingController(text: 'Now showing:');
  final _suffixController = TextEditingController(text: 'in 3D!');
  final _seqControllers = List.generate(5, (_) => TextEditingController());

  final List<String> _seqDefaults = ['Feature A', 'Feature B', 'Feature C', 'Demo', 'Preview'];
  final List<int> _seqEffectIndices = [0, 1, 2, 0, 1];

  int _seqCount = 3;
  int _displayDurationMs = 2500;
  int _transitionDurationMs = 500;
  int _transitionEffectIndex = 0;
  bool _repeat = true;
  Color _color = Colors.white;
  double _fontSize = 24;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _seqDefaults.length; i++) {
      _seqControllers[i].text = _seqDefaults[i];
    }
  }

  @override
  void dispose() {
    _prefixController.dispose();
    _suffixController.dispose();
    for (final c in _seqControllers) { c.dispose(); }
    super.dispose();
  }

  TextEffect? get _transitionEffect {
    if (_transitionEffectIndex < _effectFactories.length) {
      return _effectFactories[_transitionEffectIndex]();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Preview
        Container(
          constraints: const BoxConstraints(minHeight: 80),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_prefixController.text,
                style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold, color: _color)),
              const SizedBox(width: 6),
              Flexible(
                child: AnimatedTextSequence(
                  texts: List.generate(_seqCount, (i) => SequenceText(
                    _seqControllers[i].text,
                    effects: [_effectFactories[_seqEffectIndices[i]]()],
                  )),
                  repeat: _repeat,
                  transitionEffect: _transitionEffect,
                  displayDuration: Duration(milliseconds: _displayDurationMs),
                  transitionDuration: Duration(milliseconds: _transitionDurationMs),
                  style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold, color: _color),
                ),
              ),
              const SizedBox(width: 6),
              Text(_suffixController.text,
                style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold, color: _color)),
            ],
          ),
        ),

        _section('Prefix (static)'),
        TextField(
          controller: _prefixController,
          decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
        ),
        const SizedBox(height: 8),

        _section('Suffix (static)'),
        TextField(
          controller: _suffixController,
          decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
        ),
        const SizedBox(height: 12),

        _section('Sequence texts'),
        _slider(
          value: _seqCount.toDouble(), min: 1, max: 5, divisions: 4, label: '$_seqCount',
          onChanged: (v) => setState(() => _seqCount = v.round()),
        ),
        const SizedBox(height: 8),

        _section('Display Duration (ms)'),
        _slider(
          value: _displayDurationMs.toDouble(), min: 500, max: 6000, divisions: 11,
          label: '${_displayDurationMs}ms',
          onChanged: (v) => setState(() => _displayDurationMs = v.round()),
        ),
        const SizedBox(height: 8),

        _section('Transition Duration (ms)'),
        _slider(
          value: _transitionDurationMs.toDouble(), min: 100, max: 1500, divisions: 14,
          label: '${_transitionDurationMs}ms',
          onChanged: (v) => setState(() => _transitionDurationMs = v.round()),
        ),
        const SizedBox(height: 8),

        _section('Transition Effect'),
        DropdownButtonFormField<int>(
          value: _transitionEffectIndex,
          items: [
            const DropdownMenuItem(value: -1, child: Text('Cross-fade (none)')),
            ...List.generate(_effectNames.length, (i) {
              return DropdownMenuItem(value: i, child: Text(_effectNames[i]));
            }),
          ],
          onChanged: (v) {
            if (v != null) setState(() => _transitionEffectIndex = v);
          },
        ),
        const SizedBox(height: 8),

        _section('Font Size'),
        _slider(
          value: _fontSize, min: 12, max: 48, divisions: 36, label: '${_fontSize.round()}',
          onChanged: (v) => setState(() => _fontSize = v),
        ),
        const SizedBox(height: 8),

        _section('Color'),
        _colorSwatches(selected: _color, onSelected: (c) => setState(() => _color = c)),
        const SizedBox(height: 8),

        SwitchListTile(
          dense: true, visualDensity: VisualDensity.compact,
          title: const Text('Repeat'),
          value: _repeat,
          onChanged: (v) => setState(() => _repeat = v),
        ),
        const SizedBox(height: 16),

        // Per-sequence-item configuration
        const Text('Sequence item settings:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...List.generate(_seqCount, (i) {
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Item ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _seqControllers[i],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    value: _seqEffectIndices[i],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    ),
                    items: List.generate(_effectNames.length, (j) {
                      return DropdownMenuItem(value: j, child: Text(_effectNames[j]));
                    }),
                    onChanged: (v) {
                      if (v != null) setState(() => _seqEffectIndices[i] = v);
                    },
                  ),
                ],
              ),
            ),
          );
        }),
        const SizedBox(height: 40),
      ],
    );
  }
}
