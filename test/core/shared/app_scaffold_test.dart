import 'dart:async';

import 'package:fitness_app/core/shared/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppScaffold renders child correctly', (
    WidgetTester tester,
  ) async {
    final Completer<void> imageErrorCompleter = Completer<void>();

    // Capture and ignore image loading errors
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.toString().contains('Unable to load asset')) {
        // Ignore asset loading errors
        if (!imageErrorCompleter.isCompleted) {
          imageErrorCompleter.complete();
        }
        return;
      }
      // Re-throw other errors
      FlutterError.presentError(details);
    };

    await tester.pumpWidget(
      const MaterialApp(
        home: AppScaffold(
          backgroundImage: 'assets/images/auth_bg.png',
          child: Text('Test Child'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Test Child'), findsOneWidget);
  });
}
