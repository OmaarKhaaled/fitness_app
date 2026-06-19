import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/features/auth/register/presentation/views/widgets/gender_selection_widget.dart';
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
        body: GenderSelectionWidget(
          genderIconPath: AppIcons.maleSymbol,
          genderName: AppTextConstants.profileSetupGenderMale,
          isSelected: isSelected,
          onTap: () => tapped = true,
        ),
      ),
    );
  }

  testWidgets('GenderSelectionWidget renders correctly when selected', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget(isSelected: true));
    await tester.pumpAndSettle();

    expect(find.text(AppTextConstants.profileSetupGenderMale), findsOneWidget);
  });

  testWidgets('GenderSelectionWidget renders correctly when not selected', (
    tester,
  ) async {
    await tester.pumpWidget(buildTestableWidget(isSelected: false));
    await tester.pumpAndSettle();

    expect(find.text(AppTextConstants.profileSetupGenderMale), findsOneWidget);
  });

  testWidgets('GenderSelectionWidget calls onTap when tapped', (tester) async {
    await tester.pumpWidget(buildTestableWidget(isSelected: false));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    expect(tapped, true);
  });
}
