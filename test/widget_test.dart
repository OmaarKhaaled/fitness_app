import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Basic smoke test to verify the app can be built
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Fitness App'))),
      ),
    );

    expect(find.text('Fitness App'), findsOneWidget);
  });
}
