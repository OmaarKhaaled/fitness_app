import 'package:fitness_app/core/shared/blur_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BlurCard renders child correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: BlurCard(child: Text('Test Child'))),
      ),
    );
    expect(find.text('Test Child'), findsOneWidget);
  });
  testWidgets('BlurCard applies custom height', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: BlurCard(height: 200, child: Text('Test Child'))),
      ),
    );
    final containerFinder = find.byType(Container).first;
    tester.widget(containerFinder);
    final renderBox = tester.renderObject(find.byType(BlurCard));
    final size = (renderBox as RenderBox).size;
    expect(size.height, 200);
  });
  testWidgets('BlurCard has default height when not specified', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: BlurCard(child: Text('Test Child'))),
      ),
    );
    final renderBox = tester.renderObject(find.byType(BlurCard));
    final size = (renderBox as RenderBox).size;
    expect(size.height, greaterThan(0));
  });
}
