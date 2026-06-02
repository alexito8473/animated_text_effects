import 'package:flutter/material.dart';
import 'package:animated_text_effects/animated_text_effects.dart';

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

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEffectController();
    controller.repeat(reverse: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Animated Text Effects')),
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
