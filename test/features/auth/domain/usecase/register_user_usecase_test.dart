import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository repository;
  late RegisterUserUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RegisterUserUseCase(repository);

    registerFallbackValue(
      const AuthEntity(
        fullName: 'Bibek Pandey',
        email: 'BibekPandey@gmail.com',
        password: '212121',
        image: null,
        contact: '1234567890',
        address: 'gorkha',
      ),
    );
  });

  group('RegisterUserUseCase Tests', () {
    test('should register Bibek Pandeyy successfully', () async {
      when(() => repository.registerStudent(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(
        const RegisterUserParams(
          fullName: 'Bibek Pandey',
          email: 'Bibek@example.com',
          contact: '1234567890',
          address: 'Gorkha',
          password: 'Bibek123',
          image: null,
        ),
      );

      expect(result, equals(const Right(null)));
      verify(() => repository.registerStudent(
            const AuthEntity(
              fullName: 'Bibek Pandey',
              email: 'Bibek@example.com',
              contact: '1234567890',
              address: 'Gorkha',
              password: 'Bibek123',
              image: null,
            ),
          )).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should register Bibek Pandey with an image successfully', () async {
      when(() => repository.registerStudent(any()))
          .thenAnswer((_) async => const Right(null));

      final result = await useCase(
        const RegisterUserParams(
          fullName: 'Bibek Pandey',
          email: 'Bibek@example.com',
          contact: '1234567890',
          address: 'Gorkha',
          password: 'Bibek123',
          image: 'Bibek_profile.jpg',
        ),
      );

      expect(result, equals(const Right(null)));
      verify(() => repository.registerStudent(
            const AuthEntity(
              fullName: 'Bibek Pandey',
              email: 'Bibek@example.com',
              contact: '1234567890',
              address: 'Gorkha',
              password: 'Bibek123',
              image: 'Bibek_profile.jpg',
            ),
          )).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should handle registration failure for Bibek Pandey', () async {
      const failure =
          ApiFailure(message: 'Registration failed', statusCode: 400);
      when(() => repository.registerStudent(any()))
          .thenAnswer((_) async => const Left(failure));

      final result = await useCase(
        const RegisterUserParams(
          fullName: 'Bibek Pandey',
          email: 'Bibek@example.com',
          contact: '1234567890',
          address: 'Gorkha',
          password: 'Bibek123',
          image: null,
        ),
      );

      expect(result, equals(const Left(failure)));
      verify(() => repository.registerStudent(
            const AuthEntity(
              fullName: 'Bibek Pandey',
              email: 'Bibek@example.com',
              contact: '1234567890',
              address: 'Gorkha',
              password: 'Bibek123',
              image: null,
            ),
          )).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
