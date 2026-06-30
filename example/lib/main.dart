import 'package:flutter/material.dart';
import 'package:animated_text_effects/animated_text_effects.dart';
import 'interactive_demo.dart';
import 'counter_interactive_demo.dart';
import 'sequence_interactive_demo.dart';
import 'comprehensive_demo.dart';
import 'comprehensive_counters_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Text Effects Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  late final TextEffectController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEffectController()..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Text Effects'),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InteractiveDemo()),
            ),
            icon: const Icon(Icons.tune),
            label: const Text('Text'),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CounterInteractiveDemo()),
            ),
            icon: const Icon(Icons.format_list_numbered),
            label: const Text('Counters'),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SequenceInteractiveDemo()),
            ),
            icon: const Icon(Icons.animation),
            label: const Text('Sequence'),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ComprehensiveDemo()),
            ),
            icon: const Icon(Icons.dashboard),
            label: const Text('Comprehensive'),
          ),
          TextButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ComprehensiveCountersDemo()),
            ),
            icon: const Icon(Icons.bar_chart),
            label: const Text('Cmp Counters'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _section('Fade — una vez'),
          AnimatedText(
            'Texto que aparece letra por letra',
            effects: const [FadeEffect()],
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 32),
          _section('Wave — loop infinito'),
          AnimatedText(
            'Efecto ola infinito',
            effects: const [WaveEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Gradient — loop infinito'),
          AnimatedText(
            'Degradado animado',
            effects: const [GradientEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Bounce — rebote infinito (reverse)'),
          AnimatedText(
            'Letras que rebotan',
            effects: const [BounceEffect()],
            repeat: true,
            reverse: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Typewriter — una vez'),
          AnimatedText(
            'Efecto máquina de escribir',
            effects: const [TypewriterEffect()],
            style: const TextStyle(fontSize: 24, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 32),
          _section('Shimmer — loop infinito'),
          AnimatedText(
            'Brillo elegante',
            effects: const [ShimmerEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Slide — una vez'),
          AnimatedText(
            'Deslizándose hacia adentro',
            effects: const [SlideEffect(direction: SlideDirection.left)],
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 32),
          _section('Blur — una vez'),
          AnimatedText(
            'De borroso a nítido',
            effects: const [BlurEffect()],
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 32),
          _section('Combinado (Fade + Wave + Gradient) — loop'),
          AnimatedText(
            'Fade + Wave + Gradient',
            effects: const [
              FadeEffect(delayBetweenChars: Duration(milliseconds: 30)),
              WaveEffect(scaleMin: 0.8, scaleMax: 1.2),
              GradientEffect(colors: [Colors.cyan, Colors.purple, Colors.orange]),
            ],
            repeat: true,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.red),
          ),
          const SizedBox(height: 32),
          _section('Controller — reverse infinito'),
          AnimatedText(
            'Controlado con TextEffectController',
            effects: const [
              FadeEffect(delayBetweenChars: Duration(milliseconds: 20)),
              BounceEffect(height: 6),
            ],
            controller: controller,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Rainbow — loop infinito'),
          AnimatedText(
            'Arcoíris animado',
            effects: const [RainbowEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Glow — loop infinito'),
          AnimatedText(
            'Brillo pulsante',
            effects: const [GlowEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Ripple — una vez'),
          AnimatedText(
            'Onda expansiva',
            effects: const [RippleEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Spin — loop infinito'),
          AnimatedText(
            'Letras que giran',
            effects: const [SpinEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Flip — una vez'),
          AnimatedText(
            'Volteo 3D',
            effects: const [FlipEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Wiggle — loop infinito'),
          AnimatedText(
            'Letras que vibran',
            effects: const [WiggleEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Pulse — loop infinito'),
          AnimatedText(
            'Latido cardiaco',
            effects: const [PulseEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Scatter — una vez'),
          AnimatedText(
            'Letras dispersas',
            effects: const [ScatterEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Neon Flicker — loop infinito'),
          AnimatedText(
            'Neón parpadeante',
            effects: const [NeonFlickerEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Elastic — una vez'),
          AnimatedText(
            'Estiramiento elástico',
            effects: const [ElasticEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Highlight — una vez'),
          AnimatedText(
            'Texto resaltado',
            effects: const [HighlightEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Underline — una vez'),
          AnimatedText(
            'Subrayado animado',
            effects: const [UnderlineEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('ProgressText — una vez'),
          AnimatedText(
            '████████░░░░ 50%',
            effects: const [ProgressTextEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('StaggeredAppear — una vez'),
          AnimatedText(
            'Aparición escalonada',
            effects: const [StaggeredAppearEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Fire — loop infinito'),
          AnimatedText(
            'Fuego',
            effects: const [FireEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Smoke — una vez'),
          AnimatedText(
            'Humo',
            effects: const [SmokeEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('VHS Glitch — loop infinito'),
          AnimatedText(
            'GLITCH',
            effects: const [VHSGlitchEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 32),
          _section('Reveal — una vez'),
          AnimatedText(
            'Revelado',
            effects: const [RevealEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Liquid — loop infinito'),
          AnimatedText(
            'Líquido',
            effects: const [LiquidEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Scanner — una vez'),
          AnimatedText(
            'Escáner futurista',
            effects: const [ScannerEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('WaveColor — loop infinito'),
          AnimatedText(
            'Onda de color',
            effects: const [WaveColorEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('BreathingOpacity — loop infinito'),
          AnimatedText(
            'Respiración suave',
            effects: const [BreathingOpacityEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('ConveyorBelt — loop infinito'),
          AnimatedText(
            'Cinta transportadora',
            effects: const [ConveyorBeltEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('MeltDrip — una vez'),
          AnimatedText(
            'Derritiéndose',
            effects: const [MeltDripEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('SparkleTwinkle — loop infinito'),
          AnimatedText(
            'Destellos mágicos',
            effects: const [SparkleTwinkleEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('MatrixRain — loop infinito'),
          AnimatedText(
            'Matrix',
            effects: const [MatrixRainEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 32),
          _section('GlitchSplit — loop infinito'),
          AnimatedText(
            'RGB SPLIT',
            effects: const [GlitchSplitEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 32),
          _section('Scramble — una vez'),
          AnimatedText(
            'Descifrado',
            effects: const [ScrambleEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 32),
          _section('PopIn — una vez'),
          AnimatedText(
            'Pop In!',
            effects: const [PopInEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Shake — loop infinito'),
          AnimatedText(
            'Temblor',
            effects: const [ShakeEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('FlagWave — loop infinito'),
          AnimatedText(
            'Bandera ondeando',
            effects: const [FlagWaveEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('RandomReveal — una vez'),
          AnimatedText(
            'Orden aleatorio',
            effects: const [RandomRevealEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Tracking — loop infinito'),
          AnimatedText(
            'Espaciado variable',
            effects: const [TrackingEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('GlowReveal — una vez'),
          AnimatedText(
            'Brillo cinematográfico',
            effects: const [GlowRevealEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('KineticType — loop infinito'),
          AnimatedText(
            'Flotación cinética',
            effects: const [KineticTypeEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('SplitReveal — una vez'),
          AnimatedText(
            'Dividir y revelar',
            effects: const [SplitRevealEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('InkDrops — una vez'),
          AnimatedText(
            'Manchas de tinta',
            effects: const [InkDropsEffect()],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('ChromaticAberration — loop infinito'),
          AnimatedText(
            'Aberración cromática',
            effects: const [ChromaticAberrationEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Pixelate — loop infinito'),
          AnimatedText(
            'Pixelado que se resuelve',
            effects: const [PixelateEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('WaterRipple — loop infinito'),
          AnimatedText(
            'Onda en el agua',
            effects: const [WaterRippleEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Vortex — loop infinito'),
          AnimatedText(
            'Torbellino',
            effects: const [VortexEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Cascade — loop infinito'),
          AnimatedText(
            'Dominó',
            effects: const [CascadeEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Origami — loop infinito'),
          AnimatedText(
            'Papiroflexia',
            effects: const [OrigamiEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Shatter — loop infinito'),
          AnimatedText(
            'Fragmentos',
            effects: const [ShatterEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Morph — loop infinito'),
          AnimatedText(
            'Morfismo',
            effects: const [MorphEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Curtain — loop infinito'),
          AnimatedText(
            'Telón',
            effects: const [CurtainEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Stomp — loop infinito'),
          AnimatedText(
            'Pisotón',
            effects: const [StompEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('TypewriterError — loop infinito'),
          AnimatedText(
            'Error tipográfico',
            effects: const [TypewriterErrorEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 32),
          _section('TypewriterDelete — loop infinito'),
          AnimatedText(
            'Escribir y borrar',
            effects: const [TypewriterDeleteEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 32),
          _section('FallingLeaves — loop infinito'),
          AnimatedText(
            'Hojas cayendo',
            effects: const [FallingLeavesEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Fireflies — loop infinito'),
          AnimatedText(
            'Luciérnagas',
            effects: const [FirefliesEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Breath — loop infinito'),
          AnimatedText(
            'Respiración profunda',
            effects: const [BreathEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('CircularReveal — loop infinito'),
          AnimatedText(
            'Revelado circular',
            effects: const [CircularRevealEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('ScanLines — loop infinito'),
          AnimatedText(
            'Líneas de barrido',
            effects: const [ScanLinesEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('BarWake — loop infinito'),
          AnimatedText(
            'Barra de progreso',
            effects: const [BarWakeEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Weight — loop infinito'),
          AnimatedText(
            'Peso variable',
            effects: const [WeightEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          _section('Countdown — loop infinito'),
          AnimatedText(
            'Cuenta atrás',
            effects: const [CountdownEffect()],
            repeat: true,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 32),
          _section('AnimatedCounter — entero'),
          AnimatedCounter(
            value: 100,
            style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 32),
          _section('AnimatedCounter — decimal 2 posiciones + activeColor'),
          AnimatedCounter(
            value: 99.99,
            decimals: 2,
            activeColor: Colors.amber,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          const SizedBox(height: 32),
          _section('AnimatedCounter — scalePulse en 1500'),
          AnimatedCounter(
            value: 1500,
            scalePulse: true,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.cyan),
          ),
          const SizedBox(height: 32),
          _section('AnimatedPercentage — 75.5%'),
          AnimatedPercentage(
            value: 75.5,
            decimals: 1,
            activeColor: Colors.orange,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 32),
          _section(r'AnimatedCurrency — $1,234.56 con activeColor'),
          AnimatedCurrency(
            value: 1234.56,
            decimals: 2,
            symbol: r'$',
            activeColor: Colors.greenAccent,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          _section('AnimatedCurrency — +€ 99,9 con showPlusSign'),
          AnimatedCurrency(
            value: 99.9,
            decimals: 1,
            symbol: '€',
            showPlusSign: true,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 32),
          _section('RollingDigitCounter — 2026'),
          RollingDigitCounter(
            value: 2026,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.yellow),
          ),
          const SizedBox(height: 32),
          _section('RollingDigitCounter — 3.14159'),
          RollingDigitCounter(
            value: 3.14159,
            decimals: 5,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
          ),
          const SizedBox(height: 32),
          _section('AnimatedStatCard — fila'),
          Row(
            children: [
              Expanded(
                child: AnimatedStatCard(
                  value: 8472,
                  label: 'Users',
                  icon: Icons.people,
                  activeColor: Colors.blue,
                  scalePulse: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnimatedStatCard(
                  value: 99.9,
                  label: 'Uptime',
                  icon: Icons.check_circle,
                  decimals: 1,
                  activeColor: Colors.green,
                  format: (v) => '${v.toStringAsFixed(1)}%',
                ),
              ),
              Expanded(
                child: AnimatedStatCard(
                  value: 128,
                  label: 'Servers',
                  icon: Icons.dns,
                  activeColor: Colors.amber,
                  scalePulse: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }
}
