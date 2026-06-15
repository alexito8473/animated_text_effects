import 'package:flutter/material.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

// ──────────────────────────────────────────────────────────────
// Shared helpers
// ──────────────────────────────────────────────────────────────

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

const _iconOptions = [
  ('people', Icons.people),
  ('dns', Icons.dns),
  ('check_circle', Icons.check_circle),
  ('trending_up', Icons.trending_up),
  ('shopping_cart', Icons.shopping_cart),
  ('favorite', Icons.favorite),
  ('star', Icons.star),
  ('download', Icons.download),
  ('cloud', Icons.cloud),
  ('bar_chart', Icons.bar_chart),
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

Widget _colorSwatches({required Color selected, required ValueChanged<Color> onSelected}) {
  return Wrap(
    spacing: 6,
    runSpacing: 6,
    children: [
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
// Comprehensive Counters Demo — 3 tabs
// ──────────────────────────────────────────────────────────────

class ComprehensiveCountersDemo extends StatefulWidget {
  const ComprehensiveCountersDemo({super.key});

  @override
  State<ComprehensiveCountersDemo> createState() => _ComprehensiveCountersDemoState();
}

class _ComprehensiveCountersDemoState extends State<ComprehensiveCountersDemo>
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
      appBar: AppBar(title: const Text('Comprehensive Counters')),
      body: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(text: 'Single'),
              Tab(text: 'Dashboard'),
              Tab(text: 'Mixed'),
            ],
            controller: _tabController,
          ),
          Expanded(
            child: IndexedStack(
              index: _tabController.index,
              children: const [
                _SingleCounterTab(),
                _DashboardTab(),
                _MixedCounterTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// TAB 1 — Single Counter (all counter types in one preview)
// ──────────────────────────────────────────────────────────────

enum _CounterType { basic, decimal, percentage, currency, rolling }

const _counterLabels = {
  _CounterType.basic: 'Integer',
  _CounterType.decimal: 'Decimal',
  _CounterType.percentage: 'Percentage',
  _CounterType.currency: 'Currency',
  _CounterType.rolling: 'Odometer',
};

class _SingleCounterTab extends StatefulWidget {
  const _SingleCounterTab();

  @override
  State<_SingleCounterTab> createState() => _SingleCounterTabState();
}

class _SingleCounterTabState extends State<_SingleCounterTab> {
  int _resetKey = 0;
  Set<_CounterType> _enabledCounters = {
    _CounterType.basic, _CounterType.decimal, _CounterType.percentage,
    _CounterType.currency, _CounterType.rolling,
  };

  int _value = 4927;
  int _decimals = 0;
  int _durationMs = 1500;
  int _curveIndex = 1;
  bool _autoplay = true;
  bool _scalePulse = true;
  Color _activeColor = Colors.amber;
  String _currencySymbol = r'$';
  bool _showPercentSign = true;
  bool _showPlusSign = false;
  double _rollDigitWidth = 42;
  double _rollDigitHeight = 54;

  void _reset() => setState(() => _resetKey++);

  @override
  Widget build(BuildContext context) {
    final key = ValueKey(_resetKey);
    final curve = _curveOptions[_curveIndex];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Preview row
        Container(
          constraints: const BoxConstraints(minHeight: 140),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              key: key,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_enabledCounters.contains(_CounterType.basic))
                  _previewItem(
                    'Integer',
                    AnimatedCounter(
                      key: ValueKey('basic$_resetKey'),
                      value: _value,
                      duration: Duration(milliseconds: _durationMs),
                      curve: curve,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      autoplay: _autoplay,
                      scalePulse: _scalePulse,
                      activeColor: _activeColor,
                    ),
                  ),
                if (_enabledCounters.contains(_CounterType.decimal))
                  _previewItem(
                    'Decimal',
                    AnimatedCounter(
                      key: ValueKey('decimal$_resetKey'),
                      value: _value / 100,
                      decimals: _decimals > 2 ? _decimals : 2,
                      duration: Duration(milliseconds: _durationMs),
                      curve: curve,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      autoplay: _autoplay,
                      scalePulse: _scalePulse,
                      activeColor: _activeColor,
                    ),
                  ),
                if (_enabledCounters.contains(_CounterType.percentage))
                  _previewItem(
                    'Percentage',
                    AnimatedPercentage(
                      key: ValueKey('percent$_resetKey'),
                      value: _decimals > 0 ? _value / 100 : _value,
                      decimals: _decimals,
                      duration: Duration(milliseconds: _durationMs),
                      curve: curve,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      autoplay: _autoplay,
                      scalePulse: _scalePulse,
                      activeColor: _activeColor,
                      showPercentSign: _showPercentSign,
                    ),
                  ),
                if (_enabledCounters.contains(_CounterType.currency))
                  _previewItem(
                    'Currency',
                    AnimatedCurrency(
                      key: ValueKey('currency$_resetKey'),
                      value: _value / 100,
                      decimals: _decimals > 2 ? _decimals : 2,
                      symbol: _currencySymbol,
                      duration: Duration(milliseconds: _durationMs),
                      curve: curve,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      autoplay: _autoplay,
                      scalePulse: _scalePulse,
                      activeColor: _activeColor,
                      showPlusSign: _showPlusSign,
                    ),
                  ),
                if (_enabledCounters.contains(_CounterType.rolling))
                  _previewItem(
                    'Odometer',
                    RollingDigitCounter(
                      key: ValueKey('rolling$_resetKey'),
                      value: _value,
                      decimals: _decimals,
                      duration: Duration(milliseconds: _durationMs),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      autoplay: _autoplay,
                      digitWidth: _rollDigitWidth,
                      digitHeight: _rollDigitHeight,
                    ),
                  ),
              ],
            ),
          ),
        ),

        Center(
          child: FilledButton.icon(
            onPressed: _reset,
            icon: const Icon(Icons.refresh),
            label: const Text('Restart animations'),
          ),
        ),
        const Divider(height: 24),

        // Counter type toggles
        _section('Visible types'),
        ..._CounterType.values.map((type) {
          return CheckboxListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(_counterLabels[type]!),
            value: _enabledCounters.contains(type),
            onChanged: (v) {
              setState(() {
                if (v == true) { _enabledCounters.add(type); }
                else { _enabledCounters.remove(type); }
              });
            },
          );
        }),
        const SizedBox(height: 8),

        // Per-type controls
        for (final type in _CounterType.values)
          if (_enabledCounters.contains(type)) ...[
            _section('${_counterLabels[type]} settings'),
            _buildTypeControls(type),
          ],

        const Divider(height: 16),

        // Global controls
        _section('Global controls'),
        _section('Value'),
        _slider(value: _value.toDouble(), min: 1, max: 100000, divisions: 100, label: '$_value', onChanged: (v) => setState(() => _value = v.round())),
        _section('Decimals'),
        _slider(value: _decimals.toDouble(), min: 0, max: 6, divisions: 6, label: '$_decimals', onChanged: (v) => setState(() => _decimals = v.round())),
        _section('Duration (ms)'),
        _slider(value: _durationMs.toDouble(), min: 200, max: 5000, divisions: 24, label: '${_durationMs}ms', onChanged: (v) => setState(() => _durationMs = v.round())),
        _section('Curve'),
        DropdownButtonFormField<int>(
          value: _curveIndex,
          items: List.generate(_curveOptions.length, (i) {
            return DropdownMenuItem(value: i, child: Text(_curveOptions[i].toString()));
          }),
          onChanged: (v) { if (v != null) setState(() => _curveIndex = v); },
        ),
        const SizedBox(height: 8),
        CheckboxListTile(dense: true, visualDensity: VisualDensity.compact, title: const Text('Autoplay'), value: _autoplay, onChanged: (v) => setState(() => _autoplay = v ?? true)),
        CheckboxListTile(dense: true, visualDensity: VisualDensity.compact, title: const Text('Scale Pulse'), value: _scalePulse, onChanged: (v) => setState(() => _scalePulse = v ?? true)),
        _section('Active color'),
        _colorSwatches(selected: _activeColor, onSelected: (c) => setState(() => _activeColor = c)),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _previewItem(String label, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildTypeControls(_CounterType type) {
    switch (type) {
      case _CounterType.currency:
        return Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Symbol', border: OutlineInputBorder(), isDense: true),
              controller: TextEditingController(text: _currencySymbol),
              onChanged: (v) => setState(() => _currencySymbol = v),
            ),
            CheckboxListTile(dense: true, visualDensity: VisualDensity.compact, title: const Text('Show + sign'), value: _showPlusSign, onChanged: (v) => setState(() => _showPlusSign = v ?? false)),
          ],
        );
      case _CounterType.percentage:
        return CheckboxListTile(dense: true, visualDensity: VisualDensity.compact, title: const Text('Show % sign'), value: _showPercentSign, onChanged: (v) => setState(() => _showPercentSign = v ?? true));
      case _CounterType.rolling:
        return Column(
          children: [
            _section('Digit width'),
            _slider(value: _rollDigitWidth, min: 16, max: 80, divisions: 64, label: '${_rollDigitWidth.round()}', onChanged: (v) => setState(() => _rollDigitWidth = v)),
            _section('Digit height'),
            _slider(value: _rollDigitHeight, min: 24, max: 100, divisions: 76, label: '${_rollDigitHeight.round()}', onChanged: (v) => setState(() => _rollDigitHeight = v)),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

// ──────────────────────────────────────────────────────────────
// TAB 2 — Dashboard (AnimatedStatCards grid)
// ──────────────────────────────────────────────────────────────

class _DashboardTab extends StatefulWidget {
  const _DashboardTab();

  @override
  State<_DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<_DashboardTab> {
  int _resetKey = 0;
  int _cardCount = 4;

  final _labelControllers = List.generate(4, (_) => TextEditingController());
  final _valueControllers = List.generate(4, (_) => TextEditingController());
  final List<int> _decimals = [0, 1, 0, 0];
  final List<int> _iconIndices = [0, 1, 2, 3];
  final List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.purple,
  ];

  int _durationMs = 1200;
  int _curveIndex = 1;
  bool _scalePulse = true;

  final List<String> _defaultLabels = ['Users', 'Uptime', 'Servers', 'Revenue'];
  final List<double> _defaultValues = [8472, 99.9, 128, 49250];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      _labelControllers[i].text = _defaultLabels[i];
      _valueControllers[i].text = _defaultValues[i].toString();
    }
  }

  @override
  void dispose() {
    for (final c in _labelControllers) { c.dispose(); }
    for (final c in _valueControllers) { c.dispose(); }
    super.dispose();
  }

  void _reset() => setState(() => _resetKey++);

  @override
  Widget build(BuildContext context) {
    final curve = _curveOptions[_curveIndex];
    final key = ValueKey(_resetKey);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Preview grid
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
          ),
          child: GridView.count(
            key: key,
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: List.generate(_cardCount, (i) {
              final val = double.tryParse(_valueControllers[i].text) ?? 0;
              return AnimatedStatCard(
                key: ValueKey('sc_${i}_$_resetKey'),
                value: val,
                label: _labelControllers[i].text,
                icon: _iconOptions[_iconIndices[i]].$2,
                decimals: _decimals[i],
                duration: Duration(milliseconds: _durationMs),
                curve: curve,
                scalePulse: _scalePulse,
                activeColor: _colors[i],
              );
            }),
          ),
        ),

        Center(
          child: FilledButton.icon(
            onPressed: _reset,
            icon: const Icon(Icons.refresh),
            label: const Text('Restart'),
          ),
        ),
        const Divider(height: 24),

        _section('Number of cards'),
        _slider(value: _cardCount.toDouble(), min: 1, max: 4, divisions: 3, label: '$_cardCount', onChanged: (v) => setState(() => _cardCount = v.round())),
        const SizedBox(height: 8),

        _section('Duration (ms)'),
        _slider(value: _durationMs.toDouble(), min: 200, max: 5000, divisions: 24, label: '${_durationMs}ms', onChanged: (v) => setState(() => _durationMs = v.round())),
        _section('Curve'),
        DropdownButtonFormField<int>(
          value: _curveIndex,
          items: List.generate(_curveOptions.length, (i) {
            return DropdownMenuItem(value: i, child: Text(_curveOptions[i].toString()));
          }),
          onChanged: (v) { if (v != null) setState(() => _curveIndex = v); },
        ),
        CheckboxListTile(dense: true, visualDensity: VisualDensity.compact, title: const Text('Scale Pulse'), value: _scalePulse, onChanged: (v) => setState(() => _scalePulse = v ?? true)),
        const SizedBox(height: 12),

        // Per-card controls
        const Text('Card settings:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...List.generate(_cardCount, (i) {
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _labelControllers[i],
                    decoration: const InputDecoration(labelText: 'Label', border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _valueControllers[i],
                    decoration: const InputDecoration(labelText: 'Value', border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    value: _iconIndices[i],
                    decoration: const InputDecoration(labelText: 'Icon', border: OutlineInputBorder(), isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8)),
                    items: List.generate(_iconOptions.length, (j) {
                      return DropdownMenuItem(value: j, child: Row(
                        children: [Icon(_iconOptions[j].$2, size: 20), const SizedBox(width: 8), Text(_iconOptions[j].$1)],
                      ));
                    }),
                    onChanged: (v) { if (v != null) setState(() => _iconIndices[i] = v); },
                  ),
                  const SizedBox(height: 6),
                  _section('Decimals'),
                  _slider(value: _decimals[i].toDouble(), min: 0, max: 4, divisions: 4, label: '${_decimals[i]}', onChanged: (v) => setState(() => _decimals[i] = v.round())),
                  _section('Color'),
                  _colorSwatches(selected: _colors[i], onSelected: (c) => setState(() => _colors[i] = c)),
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
// TAB 3 — Mixed: texto estático + counter inline
// ──────────────────────────────────────────────────────────────

enum _MixedCounterType { basic, decimal, percentage, currency, rolling }

const _mixedLabels = {
  _MixedCounterType.basic: 'Integer',
  _MixedCounterType.decimal: 'Decimal',
  _MixedCounterType.percentage: 'Percentage',
  _MixedCounterType.currency: 'Currency',
  _MixedCounterType.rolling: 'Odometer',
};

class _MixedCounterTab extends StatefulWidget {
  const _MixedCounterTab();

  @override
  State<_MixedCounterTab> createState() => _MixedCounterTabState();
}

class _MixedCounterTabState extends State<_MixedCounterTab> {
  final _prefixController = TextEditingController(text: 'Total:');
  final _suffixController = TextEditingController(text: 'users online');

  int _resetKey = 0;
  _MixedCounterType _counterType = _MixedCounterType.basic;

  int _value = 8472;
  int _decimals = 0;
  int _durationMs = 1500;
  int _curveIndex = 1;
  bool _autoplay = true;
  bool _scalePulse = true;
  Color _activeColor = Colors.amber;
  double _fontSize = 28;

  // Per-type options
  String _currencySymbol = r'$';
  bool _showPercentSign = true;
  bool _showPlusSign = false;
  double _rollDigitWidth = 42;
  double _rollDigitHeight = 54;

  void _reset() => setState(() => _resetKey++);

  @override
  void dispose() {
    _prefixController.dispose();
    _suffixController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counter = _buildCounter();
    final textStyle = TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold, color: Colors.white);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Preview: static text + counter + static text
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
            key: ValueKey(_resetKey),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_prefixController.text, style: textStyle),
              const SizedBox(width: 8),
              counter,
              const SizedBox(width: 8),
              Text(_suffixController.text, style: textStyle),
            ],
          ),
        ),

        Center(
          child: FilledButton.icon(
            onPressed: _reset,
            icon: const Icon(Icons.refresh),
            label: const Text('Restart'),
          ),
        ),
        const Divider(height: 24),

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

        _section('Counter type'),
        DropdownButtonFormField<int>(
          value: _MixedCounterType.values.indexOf(_counterType),
          items: List.generate(_MixedCounterType.values.length, (i) {
            return DropdownMenuItem(value: i, child: Text(_mixedLabels[_MixedCounterType.values[i]]!));
          }),
          onChanged: (v) {
            if (v != null) setState(() => _counterType = _MixedCounterType.values[v]);
          },
        ),
        const SizedBox(height: 8),

        _section('Per-type options'),
        _buildTypeControls(),

        const Divider(height: 8),

        _section('Value'),
        _slider(value: _value.toDouble(), min: 1, max: 100000, divisions: 100, label: '$_value', onChanged: (v) => setState(() => _value = v.round())),
        _section('Decimals'),
        _slider(value: _decimals.toDouble(), min: 0, max: 6, divisions: 6, label: '$_decimals', onChanged: (v) => setState(() => _decimals = v.round())),
        _section('Duration (ms)'),
        _slider(value: _durationMs.toDouble(), min: 200, max: 5000, divisions: 24, label: '${_durationMs}ms', onChanged: (v) => setState(() => _durationMs = v.round())),
        _section('Curve'),
        DropdownButtonFormField<int>(
          value: _curveIndex,
          items: List.generate(_curveOptions.length, (i) {
            return DropdownMenuItem(value: i, child: Text(_curveOptions[i].toString()));
          }),
          onChanged: (v) { if (v != null) setState(() => _curveIndex = v); },
        ),
        const SizedBox(height: 8),
        _section('Font size'),
        _slider(value: _fontSize, min: 12, max: 64, divisions: 52, label: '${_fontSize.round()}', onChanged: (v) => setState(() => _fontSize = v)),
        CheckboxListTile(dense: true, visualDensity: VisualDensity.compact, title: const Text('Autoplay'), value: _autoplay, onChanged: (v) => setState(() => _autoplay = v ?? true)),
        CheckboxListTile(dense: true, visualDensity: VisualDensity.compact, title: const Text('Scale Pulse'), value: _scalePulse, onChanged: (v) => setState(() => _scalePulse = v ?? true)),
        _section('Active color'),
        _colorSwatches(selected: _activeColor, onSelected: (c) => setState(() => _activeColor = c)),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildCounter() {
    final curve = _curveOptions[_curveIndex];
    final style = TextStyle(fontSize: _fontSize, fontWeight: FontWeight.bold, color: _activeColor);

    switch (_counterType) {
      case _MixedCounterType.basic:
        return AnimatedCounter(
          key: ValueKey('mc_$_resetKey'),
          value: _value,
          duration: Duration(milliseconds: _durationMs),
          curve: curve,
          style: style,
          autoplay: _autoplay,
          scalePulse: _scalePulse,
          activeColor: _activeColor,
        );
      case _MixedCounterType.decimal:
        return AnimatedCounter(
          key: ValueKey('mc_$_resetKey'),
          value: _value / 100,
          decimals: _decimals > 2 ? _decimals : 2,
          duration: Duration(milliseconds: _durationMs),
          curve: curve,
          style: style,
          autoplay: _autoplay,
          scalePulse: _scalePulse,
          activeColor: _activeColor,
        );
      case _MixedCounterType.percentage:
        return AnimatedPercentage(
          key: ValueKey('mc_$_resetKey'),
          value: _decimals > 0 ? _value / 100 : _value,
          decimals: _decimals,
          duration: Duration(milliseconds: _durationMs),
          curve: curve,
          style: style,
          autoplay: _autoplay,
          scalePulse: _scalePulse,
          activeColor: _activeColor,
          showPercentSign: _showPercentSign,
        );
      case _MixedCounterType.currency:
        return AnimatedCurrency(
          key: ValueKey('mc_$_resetKey'),
          value: _value / 100,
          decimals: _decimals > 2 ? _decimals : 2,
          symbol: _currencySymbol,
          duration: Duration(milliseconds: _durationMs),
          curve: curve,
          style: style,
          autoplay: _autoplay,
          scalePulse: _scalePulse,
          activeColor: _activeColor,
          showPlusSign: _showPlusSign,
        );
      case _MixedCounterType.rolling:
        return RollingDigitCounter(
          key: ValueKey('mc_$_resetKey'),
          value: _value,
          decimals: _decimals,
          duration: Duration(milliseconds: _durationMs),
          style: style,
          autoplay: _autoplay,
          digitWidth: _rollDigitWidth,
          digitHeight: _rollDigitHeight,
        );
    }
  }

  Widget _buildTypeControls() {
    switch (_counterType) {
      case _MixedCounterType.currency:
        return Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Symbol', border: OutlineInputBorder(), isDense: true),
              controller: TextEditingController(text: _currencySymbol),
              onChanged: (v) => setState(() => _currencySymbol = v),
            ),
            CheckboxListTile(dense: true, visualDensity: VisualDensity.compact, title: const Text('Show + sign'), value: _showPlusSign, onChanged: (v) => setState(() => _showPlusSign = v ?? false)),
          ],
        );
      case _MixedCounterType.percentage:
        return CheckboxListTile(dense: true, visualDensity: VisualDensity.compact, title: const Text('Show % sign'), value: _showPercentSign, onChanged: (v) => setState(() => _showPercentSign = v ?? true));
      case _MixedCounterType.rolling:
        return Column(
          children: [
            _section('Digit width'),
            _slider(value: _rollDigitWidth, min: 16, max: 80, divisions: 64, label: '${_rollDigitWidth.round()}', onChanged: (v) => setState(() => _rollDigitWidth = v)),
            _section('Digit height'),
            _slider(value: _rollDigitHeight, min: 24, max: 100, divisions: 76, label: '${_rollDigitHeight.round()}', onChanged: (v) => setState(() => _rollDigitHeight = v)),
          ],
        );
      default:
        return const Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text('No extra options', style: TextStyle(color: Colors.grey, fontSize: 12)),
        );
    }
  }
}
