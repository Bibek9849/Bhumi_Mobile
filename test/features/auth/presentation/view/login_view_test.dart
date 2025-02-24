import 'package:bhumi_mobile/features/auth/presentation/view/login_view.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/login_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc loginBloc;

  setUp(() {
    loginBloc = MockLoginBloc();
  });

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
    await tester.pumpAndSettle();

    final result = find.widgetWithText(ElevatedButton, 'Login');

    expect(result, findsOneWidget);
  });

  testWidgets('check for the username and password ', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'bibek');
    await tester.enterText(find.byType(TextField).at(1), 'bibek123');

    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(find.text('bibek'), findsOneWidget);
    expect(find.text('bibek123'), findsOneWidget);
  });

  testWidgets('check for the validator  ', (tester) async {
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), '');
    await tester.enterText(find.byType(TextField).at(1), '');

    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(find.text('Please enter your contact'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('login success', (tester) async {
    when(() => loginBloc.state)
        .thenReturn(LoginState(isLoading: true, isSuccess: true));
    await tester.pumpWidget(loadLoginView());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'bibek');
    await tester.enterText(find.byType(TextField).at(1), 'bibek123');

    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pumpAndSettle();

    expect(loginBloc.state.isSuccess, true);
  });
}
