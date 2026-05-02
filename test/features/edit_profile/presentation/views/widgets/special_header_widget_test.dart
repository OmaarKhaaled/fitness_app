import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/edit_profile/presentation/views/widgets/special_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SpecialHeaderWidget renders and responds to tap', (
    tester,
  ) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpecialHeaderWidget(
            header: 'Test Header',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify all parts are rendered
    expect(find.text('Test Header ('), findsOneWidget);
    expect(find.text(AppTextConstants.tapToEdit), findsOneWidget);
    expect(find.text(')'), findsOneWidget);

    // Tap and verify
    await tester.tap(find.text(AppTextConstants.tapToEdit));
    await tester.pump();

    expect(tapped, true);
  });
}
