import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
// Import your real classes
import 'package:bhumi_mobile/features/auth/domain/use_case/login_use_case.dart'
    show LoginUseCase, LoginParams;
import 'package:bhumi_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ------------------
// Mock Classes
// ------------------
class MockSignupBloc extends Mock implements SignupBloc {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

// ------------------
// Dummy / Fake Classes
// ------------------
class DummyBuildContext extends Fake implements BuildContext {}

// We must register a fallback for any custom classes
// that are used with `any<T>()` in mocktail.
void main() {
  setUpAll(() {
    registerFallbackValue(const LoginParams(contact: '', password: ''));
  });

  late MockSignupBloc mockSignupBloc;
  late MockHomeCubit mockHomeCubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockTokenSharedPrefs mockTokenSharedPrefs;
  late LoginBloc loginBloc;
  late BuildContext dummyContext;

  setUp(() {
    mockSignupBloc = MockSignupBloc();
    mockHomeCubit = MockHomeCubit();
    mockLoginUseCase = MockLoginUseCase();
    mockTokenSharedPrefs = MockTokenSharedPrefs();

    dummyContext = DummyBuildContext();

    loginBloc = LoginBloc(
      signupBloc: mockSignupBloc,
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUseCase,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  tearDown(() {
    loginBloc.close();
  });

  // ------------------------------
  // Test 1: Initial State
  // ------------------------------
  test('Initial state is correct', () {
    expect(loginBloc.state, LoginState.initial());
  });

  // ------------------------------
  // Test 2: Successful Login
  // ------------------------------
  blocTest<LoginBloc, LoginState>(
    'emits [isLoading: true, isSuccess: true] when login is successful',
    build: () {
      // 1) Mock successful login: returns a token
      when(() => mockLoginUseCase(any<LoginParams>()))
          .thenAnswer((_) async => const Right('validToken'));

      // 2) Mock saving the token returns a Future<Either<Failure, void>>
      //    If your real code does something different, adjust accordingly.
      when(() => mockTokenSharedPrefs.saveToken(any()))
          .thenAnswer((_) async => const Right<Failure, void>(null));

      return loginBloc;
    },
    act: (bloc) => bloc.add(
      LoginUserEvent(
        context: dummyContext,
        contact: 'test@example.com',
        password: 'password',
      ),
    ),
    expect: () => [
      // After dispatching the event, the bloc sets isLoading: true
      LoginState.initial().copyWith(isLoading: true),
      // Then after success, isLoading: false, isSuccess: true
      LoginState.initial().copyWith(isLoading: false, isSuccess: true),
    ],
    verify: (_) {
      verify(() => mockLoginUseCase(any<LoginParams>())).called(1);
      verify(() => mockTokenSharedPrefs.saveToken('validToken')).called(1);
    },
  );

  // ------------------------------
  // Test 3: Failed Login
  // ------------------------------
  // blocTest<LoginBloc, LoginState>(
  //   'emits [isLoading: true, isSuccess: false] when login fails',
  //   build: () {
  //     // Mock a failed login returning a Failure
  //     when(() => mockLoginUseCase(any<LoginParams>()))
  //         .thenAnswer((_) async => const Left(Failure('error')));
  //     return loginBloc;
  //   },
  //   act: (bloc) => bloc.add(
  //     LoginUserEvent(
  //       context: dummyContext,
  //       contact: 'test@example.com',
  //       password: 'wrongpassword',
  //     ),
  //   ),
  //   expect: () => [
  //     LoginState.initial().copyWith(isLoading: true),
  //     LoginState.initial().copyWith(isLoading: false, isSuccess: false),
  //   ],
  //   verify: (_) {
  //     verify(() => mockLoginUseCase(any<LoginParams>())).called(1);
  //   },
  // );

  // ------------------------------
  // Test 4: Navigate to Register
  // ------------------------------
  blocTest<LoginBloc, LoginState>(
    'handles NavigateRegisterScreenEvent without state changes',
    build: () => loginBloc,
    act: (bloc) => bloc.add(NavigateRegisterScreenEvent(
      context: dummyContext,
      destination: Container(), // Example placeholder widget
    )),
    expect: () => [],
  );

  // ------------------------------
  // Test 5: Navigate to Home
  // ------------------------------
  blocTest<LoginBloc, LoginState>(
    'handles NavigateHomeScreenEvent without state changes',
    build: () => loginBloc,
    act: (bloc) => bloc.add(NavigateHomeScreenEvent(
      context: dummyContext,
      destination: Container(), // Example placeholder widget
    )),
    expect: () => [],
  );
}
