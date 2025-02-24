import 'package:bhumi_mobile/features/auth/presentation/view/register_view.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/signup_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockRegisterBloc extends MockBloc<SignupEvent, SignupState>
    implements SignupBloc {}

void main() {
  late MockRegisterBloc registerBloc;

  setUp(() {
    registerBloc = MockRegisterBloc();
  });

  Widget loadRegisterView(Widget body) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<SignupBloc>.value(value: registerBloc),
        ],
        child: const RegisterView(),
      ),
    );
  }

  testWidgets('Check for the title "Create Account"', (tester) async {
    await tester.pumpWidget(loadRegisterView(const RegisterView()));

    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsOneWidget);
  });

  // Test all the fields
  testWidgets('test allthe fields', (tester) async {
    await tester.pumpWidget(loadRegisterView(const RegisterView()));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Bibek Pandey');
    await tester.enterText(find.byType(TextFormField).at(1), 'bibek@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(2), '9844332211');
    await tester.enterText(find.byType(TextFormField).at(3), 'Gorkha');
    await tester.enterText(find.byType(TextFormField).at(4), 'kiran123');
    await tester.enterText(find.byType(TextFormField).at(4), 'kiran123');

    //=========================== Find the register button===========================
    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    expect(find.text('Bibek Pandey'), findsOneWidget);
    expect(find.text('bibek@gmail.com'), findsOneWidget);
    expect(find.text('9844332211'), findsOneWidget);
    expect(find.text('Gorkha'), findsOneWidget);
    expect(find.text('kiran123'), findsOneWidget);
    expect(find.text('kiran123'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(registerBloc.state.isSuccess, true);
  });
}
