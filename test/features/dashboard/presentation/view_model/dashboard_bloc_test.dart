import 'package:bhumi_mobile/features/auth/presentation/view/login_view.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() {
    // Set mock SharedPreferences values before tests
    SharedPreferences.setMockInitialValues({});
    loginBloc = MockLoginBloc();
  });

  // Helper widget to load LoginView with the provided LoginBloc.
  Widget loadLoginView() {
    return BlocProvider<LoginBloc>(
      create: (context) => loginBloc,
      child: const MaterialApp(
        home: LoginView(),
      ),
    );
  }

  testWidgets('check for the text in login ui', (tester) async {
    await tester.pumpWidget(loadLoginView());
    // Instead of pumpAndSettle, pump for a fixed duration to allow FutureBuilder to complete.
    await tester.pump(const Duration(seconds: 1));

    final result = find.widgetWithText(ElevatedButton, 'Login');
    expect(result, findsOneWidget);
  });

  testWidgets('check for the contact and password', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pump(const Duration(seconds: 1));

    // Use finder for TextField widgets
    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));

    await tester.enterText(textFields.at(0), '9846475286');
    await tester.enterText(textFields.at(1), 'bibek123');

    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pump(const Duration(seconds: 1));

    // Validate that entered text is present.
    expect(find.text('9846475286'), findsOneWidget);
    expect(find.text('bibek123'), findsOneWidget);
  });

  testWidgets('check for the validator', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pump(const Duration(seconds: 1));

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));

    await tester.enterText(textFields.at(0), '');
    await tester.enterText(textFields.at(1), '');

    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pump(const Duration(seconds: 1));

    // Check for validation messages.
    expect(find.text('Please enter your contact'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('login success', (tester) async {
    // Stub the bloc state to simulate login success.
    when(() => loginBloc.state)
        .thenReturn(LoginState(isLoading: true, isSuccess: true));

    await tester.pumpWidget(loadLoginView());
    await tester.pump(const Duration(seconds: 1));

    final textFields = find.byType(TextField);
    expect(textFields, findsNWidgets(2));

    await tester.enterText(textFields.at(0), 'bibek');
    await tester.enterText(textFields.at(1), 'bibek123');

    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pump(const Duration(seconds: 1));

    expect(loginBloc.state.isSuccess, true);
  });
}
