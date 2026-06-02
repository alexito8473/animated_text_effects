import 'package:flutter_test/flutter_test.dart';
import 'package:animated_text_effects_example/main.dart';

void main() {
  testWidgets('Demo app renders all effects', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Animated Text Effects'), findsOneWidget);
    expect(find.text('Fade Effect'), findsOneWidget);
    expect(find.text('Wave Effect'), findsOneWidget);
    expect(find.text('Gradient Effect'), findsOneWidget);
    expect(find.text('Fade + Wave + Gradient'), findsOneWidget);
  });
}
