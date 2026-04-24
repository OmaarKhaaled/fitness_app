import 'package:fitness_app/features/auth/register/presentation/views/widgets/radio_option_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late bool tapped;

  setUp(() {
    tapped = false;
  });

  Widget buildTestableWidget({required bool isSelected}) {
    return MaterialApp(
      home: Scaffold(
        body: RadioOptionSelectionWidget(
          option: 'Test Option',
          onTap: () => tapped = true,
          isSelected: isSelected,
        ),
      ),
    );
  }

  testWidgets('RadioOptionSelectionWidget renders correctly', (tester) async {
    await tester.pumpWidget(buildTestableWidget(isSelected: false));
    await tester.pumpAndSettle();

    expect(find.text('Test Option'), findsOneWidget);
  });

  testWidgets('RadioOptionSelectionWidget calls onTap when tapped', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget(isSelected: false));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(tapped, true);
  });
}
