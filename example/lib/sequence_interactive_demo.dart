import 'package:flutter/material.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

class SequenceInteractiveDemo extends StatefulWidget {
  const SequenceInteractiveDemo({super.key});

  @override
  State<SequenceInteractiveDemo> createState() =>
      _SequenceInteractiveDemoState();
}

class _SequenceInteractiveDemoState extends State<SequenceInteractiveDemo> {
  int _selectedEffectA = 0;
  int _selectedEffectB = 0;
  int _selectedTransition = 0;
  bool _repeat = true;

  static const List<TextEffect Function()> _effectFactories = [
    FadeEffect.new,
    SlideEffect.new,
    BlurEffect.new,
    WaveEffect.new,
    TrackingEffect.new,
    GlowRevealEffect.new,
    KineticTypeEffect.new,
    SplitRevealEffect.new,
    InkDropsEffect.new,
  ];

  static const List<String> _effectNames = [
    'Fade',
    'Slide',
    'Blur',
    'Wave',
    'Tracking',
    'GlowReveal',
    'Kinetic',
    'Split',
    'InkDrops',
  ];

  SequenceText _buildTextA() => SequenceText(
        'Hello Sequence!',
        effects: [_effectFactories[_selectedEffectA]()],
      );

  SequenceText _buildTextB() => SequenceText(
        'Next Text Here',
        effects: [_effectFactories[_selectedEffectB]()],
      );

  TextEffect? get _transitionEffect {
    if (_selectedTransition < _effectFactories.length) {
      return _effectFactories[_selectedTransition]();
    }
    return null;
  }

  String get _transitionLabel {
    if (_selectedTransition < _effectNames.length) {
      return _effectNames[_selectedTransition];
    }
    return 'Cross-fade';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sequence Interactive Demo')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'AnimatedTextSequence',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: Center(
              child: AnimatedTextSequence(
                texts: [_buildTextA(), _buildTextB()],
                repeat: _repeat,
                transitionEffect: _transitionEffect,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Effect A selector
          Text('Effect for Text A: ${_effectNames[_selectedEffectA]}'),
          const SizedBox(height: 4),
          _effectSlider(_selectedEffectA, (v) {
            setState(() => _selectedEffectA = v);
          }),

          const SizedBox(height: 16),

          // Effect B selector
          Text('Effect for Text B: ${_effectNames[_selectedEffectB]}'),
          const SizedBox(height: 4),
          _effectSlider(_selectedEffectB, (v) {
            setState(() => _selectedEffectB = v);
          }),

          const SizedBox(height: 16),

          // Transition effect selector
          Text('Transition: $_transitionLabel'),
          const SizedBox(height: 4),
          Slider(
            value: _selectedTransition.toDouble(),
            min: 0,
            max: _effectFactories.length.toDouble(),
            divisions: _effectFactories.length,
            label: _transitionLabel,
            onChanged: (v) {
              setState(() => _selectedTransition = v.round());
            },
          ),

          const SizedBox(height: 24),

          // Repeat toggle
          SwitchListTile(
            title: const Text('Repeat'),
            value: _repeat,
            onChanged: (v) => setState(() => _repeat = v),
          ),

          const SizedBox(height: 32),

          // AnimatedRichText demo
          const Text(
            'AnimatedRichText',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: Center(
              child: AnimatedRichText(
                segments: [
                  const TextSegment.static('Static '),
                  TextSegment.animated('Animated ', effects: [FadeEffect()]),
                  const TextSegment.static('Static'),
                ],
                repeat: true,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _effectSlider(int value, ValueChanged<int> onChanged) {
    return Slider(
      value: value.toDouble(),
      min: 0,
      max: (_effectFactories.length - 1).toDouble(),
      divisions: _effectFactories.length - 1,
      label: _effectNames[value],
      onChanged: (v) => onChanged(v.round()),
    );
  }
}
