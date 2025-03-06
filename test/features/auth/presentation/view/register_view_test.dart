import 'package:bhumi_mobile/features/auth/presentation/view/register_view.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Fake class for SignupState
class FakeSignupState extends Fake implements SignupState {}

// Fake class for SignupBloc using MockBloc from bloc_test
class FakeSignupBloc extends MockBloc<SignupEvent, SignupState>
    implements SignupBloc {}

void main() {
  // Remove the generic type argument from registerFallbackValue.
  setUpAll(() {
    registerFallbackValue(FakeSignupState());
  });

  group('RegisterView Widget Tests', () {
    late SignupBloc signupBloc;

    setUp(() {
      signupBloc = FakeSignupBloc();
    });

    testWidgets('RegisterView displays all required fields',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<SignupBloc>.value(
          value: signupBloc,
          child: const MaterialApp(
            home: RegisterView(),
          ),
        ),
      );

      // Verify that the main header is present.
      expect(find.text('Create Account'), findsOneWidget);

      // Verify that the form fields are present.
      expect(find.byType(TextFormField), findsNWidgets(6));
      expect(find.widgetWithText(TextFormField, 'Full Name'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
      expect(
          find.widgetWithText(TextFormField, 'Phone Number'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Address'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Confirm Password'),
          findsOneWidget);

      // Verify that the Register button is present.
      expect(find.widgetWithText(ElevatedButton, 'Register'), findsOneWidget);

      // Verify that the Login navigation text is present.
      expect(find.text('Login here'), findsOneWidget);
    });
  });
}
