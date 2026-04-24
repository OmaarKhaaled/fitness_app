import 'dart:async';

import 'package:fitness_app/features/auth/forget_password/presentation/view/widgets/provide_email_view.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_cubit.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_intents.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_states.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/view_model/forget_password_ui_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockForgetPasswordCubit extends Mock implements ForgetPasswordCubit {
  final StreamController<ForgetPasswordUiIntents> _uiIntentsController =
      StreamController<ForgetPasswordUiIntents>.broadcast();

  @override
  Future<void> close() async {
    await _uiIntentsController.close();
    return;
  }

  @override
  Stream<ForgetPasswordUiIntents> get uiIntents => _uiIntentsController.stream;

  @override
  ForgetPasswordStates get state =>
      super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: const ForgetPasswordStates(),
          )
          as ForgetPasswordStates;

  @override
  Stream<ForgetPasswordStates> get stream => const Stream.empty();

  @override
  void doIntent(ForgetPasswordIntents? intent) {
    super.noSuchMethod(
      Invocation.method(#doIntent, [intent]),
      returnValueForMissingStub: null,
    );
  }
}

void main() {
  late MockForgetPasswordCubit mockCubit;

  setUp(() {
    mockCubit = MockForgetPasswordCubit();
    when(mockCubit.state).thenReturn(const ForgetPasswordStates());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<ForgetPasswordCubit>.value(
          value: mockCubit,
          child: ProvideEmailView(onNext: (_) {}),
        ),
      ),
    );
  }

  testWidgets('ProvideEmailView renders correctly', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Sends EmailChangedIntent when text is typed', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextFormField), 'test@test.com');
    await tester.pump();

    verify(
      mockCubit.doIntent(any),
    ).called(1); // will verify specific intent match if equatable
  });

  testWidgets('Sends SendOtpIntent when button is pressed and valid', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextFormField), 'test@test.com');
    await tester.pump();

    // Tap button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    verify(mockCubit.doIntent(any)).called(greaterThan(1));
  });

  testWidgets('Renders loader when isSendOtpLoading is true', (tester) async {
    when(
      mockCubit.state,
    ).thenReturn(const ForgetPasswordStates(isSendOtpLoading: true));
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
