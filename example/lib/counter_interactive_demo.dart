import 'package:flutter/material.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

enum _CounterType {
  basic,
  decimal,
  percentage,
  currency,
  rolling,
  statCard,
}

const _counterLabels = {
  _CounterType.basic: 'Básico (entero)',
  _CounterType.decimal: 'Decimal',
  _CounterType.percentage: 'Porcentaje',
  _CounterType.currency: 'Moneda',
  _CounterType.rolling: 'Odómetro',
  _CounterType.statCard: 'Tarjeta',
};

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

class CounterInteractiveDemo extends StatefulWidget {
  const CounterInteractiveDemo({super.key});

  @override
  State<CounterInteractiveDemo> createState() => _CounterInteractiveDemoState();
}

class _CounterInteractiveDemoState extends State<CounterInteractiveDemo> {
  int _resetKey = 0;
  Set<_CounterType> _enabledCounters = {_CounterType.basic};

  int _value = 1000;
  int _decimals = 0;
  int _durationMs = 1500;
  Curve _curve = Curves.easeOut;
  bool _autoplay = true;
  bool _scalePulse = true;
  Color _activeColor = Colors.amber;

  String _currencySymbol = r'$';
  bool _showPercentSign = true;
  bool _showPlusSign = false;

  double _rollDigitWidth = 28;
  double _rollDigitHeight = 40;

  String _statLabel = 'Usuarios';
  String _statIcon = 'people';

  void _reset() {
    setState(() {
      _resetKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final previewKey = ValueKey(_resetKey);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Interactive'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reiniciar animaciones',
            onPressed: _reset,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: 200,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildPreviews(previewKey),
              ),
            ),
          ),
          const Divider(height: 24),
          Center(
            child: FilledButton.icon(
              onPressed: _reset,
              icon: const Icon(Icons.refresh),
              label: const Text('Reiniciar animaciones'),
            ),
          ),
          const Divider(height: 24),
          _section('Contadores (marcar para mostrar)'),
          const SizedBox(height: 4),
          ..._CounterType.values.map((type) {
            final enabled = _enabledCounters.contains(type);
            return Column(
              children: [
                CheckboxListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  title: Text(_counterLabels[type]!),
                  value: enabled,
                  onChanged: (v) {
                    setState(() {
                      if (v == true) {
                        _enabledCounters.add(type);
                      } else {
                        _enabledCounters.remove(type);
                      }
                    });
                  },
                ),
                if (enabled)
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: _buildCounterControls(type),
                  ),
              ],
            );
          }),
          const SizedBox(height: 16),
          _section('Controles globales'),
          _section('Valor numérico'),
          _slider(
            value: _value.toDouble(),
            min: 1,
            max: 100000,
            divisions: 100,
            label: '$_value',
            onChanged: (v) => setState(() => _value = v.round()),
          ),
          _section('Decimales'),
          _slider(
            value: _decimals.toDouble(),
            min: 0,
            max: 6,
            divisions: 6,
            label: '$_decimals',
            onChanged: (v) => setState(() => _decimals = v.round()),
          ),
          _section('Duración (ms)'),
          _slider(
            value: _durationMs.toDouble(),
            min: 200,
            max: 5000,
            divisions: 24,
            label: '${_durationMs}ms',
            onChanged: (v) => setState(() => _durationMs = v.round()),
          ),
          _section('Curva'),
          DropdownButtonFormField<Curve>(
            value: _curve,
            items: _curveOptions.map((c) {
              return DropdownMenuItem(value: c, child: Text(c.toString()));
            }).toList(),
            onChanged: (v) {
              if (v != null) setState(() => _curve = v);
            },
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: const Text('Autoplay'),
            value: _autoplay,
            onChanged: (v) => setState(() => _autoplay = v ?? true),
          ),
          CheckboxListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: const Text('Scale Pulse'),
            value: _scalePulse,
            onChanged: (v) => setState(() => _scalePulse = v ?? true),
          ),
          _section('Color activo'),
          _colorSwatches(
            selected: _activeColor,
            onSelected: (c) => setState(() => _activeColor = c),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPreviews(Key previewKey) {
    final baseStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: _activeColor,
    );

    return Row(
      key: previewKey,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_enabledCounters.contains(_CounterType.basic))
          _previewBox(
            label: 'Entero',
            child: AnimatedCounter(
              key: ValueKey('basic$_resetKey'),
              value: _value,
              duration: Duration(milliseconds: _durationMs),
              curve: _curve,
              style: baseStyle,
              autoplay: _autoplay,
              scalePulse: _scalePulse,
              activeColor: _activeColor,
            ),
          ),
        if (_enabledCounters.contains(_CounterType.decimal))
          _previewBox(
            label: 'Decimal',
            child: AnimatedCounter(
              key: ValueKey('decimal$_resetKey'),
              value: _value / 100,
              decimals: _decimals > 2 ? _decimals : 2,
              duration: Duration(milliseconds: _durationMs),
              curve: _curve,
              style: baseStyle.copyWith(fontSize: 24),
              autoplay: _autoplay,
              scalePulse: _scalePulse,
              activeColor: _activeColor,
            ),
          ),
        if (_enabledCounters.contains(_CounterType.percentage))
          _previewBox(
            label: 'Porcentaje',
            child: AnimatedPercentage(
              key: ValueKey('percent$_resetKey'),
              value: _decimals > 0 ? _value / 100 : _value,
              decimals: _decimals,
              duration: Duration(milliseconds: _durationMs),
              curve: _curve,
              style: baseStyle,
              autoplay: _autoplay,
              scalePulse: _scalePulse,
              activeColor: _activeColor,
              showPercentSign: _showPercentSign,
            ),
          ),
        if (_enabledCounters.contains(_CounterType.currency))
          _previewBox(
            label: 'Moneda',
            child: AnimatedCurrency(
              key: ValueKey('currency$_resetKey'),
              value: _value / 100,
              decimals: _decimals > 2 ? _decimals : 2,
              symbol: _currencySymbol,
              duration: Duration(milliseconds: _durationMs),
              curve: _curve,
              style: baseStyle.copyWith(fontSize: 22),
              autoplay: _autoplay,
              scalePulse: _scalePulse,
              activeColor: _activeColor,
              showPlusSign: _showPlusSign,
            ),
          ),
        if (_enabledCounters.contains(_CounterType.rolling))
          _previewBox(
            label: 'Odómetro',
            child: RollingDigitCounter(
              key: ValueKey('rolling$_resetKey'),
              value: _value,
              decimals: _decimals,
              duration: Duration(milliseconds: _durationMs),
              style: baseStyle.copyWith(fontSize: 22),
              autoplay: _autoplay,
              digitWidth: _rollDigitWidth,
              digitHeight: _rollDigitHeight,
            ),
          ),
        if (_enabledCounters.contains(_CounterType.statCard))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: 160,
              child: AnimatedStatCard(
                key: ValueKey('statcard$_resetKey'),
                value: _value,
                label: _statLabel,
                icon: _iconFromName(_statIcon),
                duration: Duration(milliseconds: _durationMs),
                curve: _curve,
                decimals: _decimals,
                activeColor: _activeColor,
                scalePulse: _scalePulse,
                autoplay: _autoplay,
              ),
            ),
          ),
      ],
    );
  }

  Widget _previewBox({required String label, required Widget child}) {
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

  Widget _buildCounterControls(_CounterType type) {
    switch (type) {
      case _CounterType.currency:
        return Column(
          children: [
            _section('Símbolo'),
            TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
              controller: TextEditingController(text: _currencySymbol),
              onChanged: (v) => setState(() => _currencySymbol = v),
            ),
            CheckboxListTile(
              dense: true, visualDensity: VisualDensity.compact,
              title: const Text('Signo +'),
              value: _showPlusSign,
              onChanged: (v) => setState(() => _showPlusSign = v ?? false),
            ),
          ],
        );
      case _CounterType.percentage:
        return CheckboxListTile(
          dense: true, visualDensity: VisualDensity.compact,
          title: const Text('Mostrar %'),
          value: _showPercentSign,
          onChanged: (v) => setState(() => _showPercentSign = v ?? true),
        );
      case _CounterType.rolling:
        return Column(
          children: [
            _section('Ancho dígito'),
            _slider(
              value: _rollDigitWidth, min: 16, max: 60, divisions: 44,
              label: '${_rollDigitWidth.round()}',
              onChanged: (v) => setState(() => _rollDigitWidth = v),
            ),
            _section('Alto dígito'),
            _slider(
              value: _rollDigitHeight, min: 24, max: 80, divisions: 56,
              label: '${_rollDigitHeight.round()}',
              onChanged: (v) => setState(() => _rollDigitHeight = v),
            ),
          ],
        );
      case _CounterType.statCard:
        return Column(
          children: [
            _section('Etiqueta'),
            TextField(
              decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true),
              controller: TextEditingController(text: _statLabel),
              onChanged: (v) => setState(() => _statLabel = v),
            ),
            _section('Icono'),
            DropdownButtonFormField<String>(
              value: _statIcon,
              items: ['people', 'dns', 'check_circle', 'trending_up', 'shopping_cart', 'favorite', 'star']
                  .map((n) => DropdownMenuItem(value: n, child: Row(
                    children: [
                      Icon(_iconFromName(n), size: 20),
                      const SizedBox(width: 8),
                      Text(n),
                    ],
                  )))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _statIcon = v);
              },
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  IconData _iconFromName(String name) {
    switch (name) {
      case 'dns': return Icons.dns;
      case 'check_circle': return Icons.check_circle;
      case 'trending_up': return Icons.trending_up;
      case 'shopping_cart': return Icons.shopping_cart;
      case 'favorite': return Icons.favorite;
      case 'star': return Icons.star;
      default: return Icons.people;
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

  Widget _colorSwatches({required Color selected, required ValueChanged<Color> onSelected}) {
    return Wrap(
      spacing: 6, runSpacing: 6,
      children: [
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
