import 'dart:io';

import 'package:bhumi_mobile/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Create mocks for the use cases.
class MockRegisterUserUseCase extends Mock implements RegisterUserUseCase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

// Create a fake BuildContext to pass in RegisterUser event.
class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  // Register the fallback value for BuildContext used by mocktail.
  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  late MockRegisterUserUseCase mockRegisterUserUseCase;
  late MockUploadImageUsecase mockUploadImageUsecase;
  late SignupBloc signupBloc;

  // Helper expected states (adjust based on your actual SignupState fields)
  const initialState = SignupState.initial();
  final loadingState = initialState.copyWith(isLoading: true);
  final successState = initialState.copyWith(isLoading: false, isSuccess: true);
  final failureState =
      initialState.copyWith(isLoading: false, isSuccess: false);

  setUp(() {
    mockRegisterUserUseCase = MockRegisterUserUseCase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    signupBloc = SignupBloc(
      registerUseCase: mockRegisterUserUseCase,
      uploadImageUsecase: mockUploadImageUsecase,
    );
  });

  group('RegisterUser Event', () {
    // Create a dummy context for the event.
    final dummyContext = FakeBuildContext();

    blocTest<SignupBloc, SignupState>(
      'emits [loading, success] when registration is successful',
      build: () {
        // Stub the use case to return a Right result.
        when(() => mockRegisterUserUseCase.call(any()))
            .thenAnswer((_) async => const Right('dummyUser'));
        return signupBloc;
      },
      act: (bloc) => bloc.add(RegisterUser(
        fullName: 'John Doe',
        email: 'john@example.com',
        contact: '1234567890',
        address: '123 Main St',
        password: 'password',
        context: dummyContext,
      )),
      expect: () => [
        loadingState,
        successState,
      ],
      verify: (_) {
        verify(() => mockRegisterUserUseCase.call(any())).called(1);
      },
    );

    blocTest<SignupBloc, SignupState>(
      'emits [loading, failure] when registration fails',
      build: () {
        // Stub the use case to return a Left result.
        when(() => mockRegisterUserUseCase.call(any()))
            .thenAnswer((_) async => const Left('error'));
        return signupBloc;
      },
      act: (bloc) => bloc.add(RegisterUser(
        fullName: 'John Doe',
        email: 'john@example.com',
        contact: '1234567890',
        address: '123 Main St',
        password: 'password',
        context: dummyContext,
      )),
      expect: () => [
        loadingState,
        failureState,
      ],
      verify: (_) {
        verify(() => mockRegisterUserUseCase.call(any())).called(1);
      },
    );
  });

  group('UploadImage Event', () {
    // Create a dummy file for the event.
    final dummyFile = File('dummy_path');

    blocTest<SignupBloc, SignupState>(
      'emits [loading, success] when image upload is successful',
      build: () {
        when(() => mockUploadImageUsecase.call(any()))
            .thenAnswer((_) async => const Right('imageName.png'));
        return signupBloc;
      },
      act: (bloc) => bloc.add(UploadImage(file: dummyFile)),
      expect: () => [
        loadingState,
        initialState.copyWith(
          isLoading: false,
          isSuccess: true,
          imageName: 'imageName.png',
        ),
      ],
      verify: (_) {
        verify(() => mockUploadImageUsecase.call(any())).called(1);
      },
    );

    blocTest<SignupBloc, SignupState>(
      'emits [loading, failure] when image upload fails',
      build: () {
        when(() => mockUploadImageUsecase.call(any()))
            .thenAnswer((_) async => const Left('error'));
        return signupBloc;
      },
      act: (bloc) => bloc.add(UploadImage(file: dummyFile)),
      expect: () => [
        loadingState,
        failureState,
      ],
      verify: (_) {
        verify(() => mockUploadImageUsecase.call(any())).called(1);
      },
    );
  });
}
