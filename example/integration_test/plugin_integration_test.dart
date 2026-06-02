import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:animated_text_effects/animated_text_effects.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('renders animated text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedText(
          'Plugin test',
          effects: const [FadeEffect(delayBetweenChars: Duration.zero)],
          autoplay: false,
        ),
      ),
    );

    expect(find.text('P'), findsOneWidget);
    expect(find.text('t'), findsWidgets);
  });
}
