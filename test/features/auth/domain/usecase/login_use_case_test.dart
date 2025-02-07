import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/login_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;
  late LoginUseCase loginUseCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    loginUseCase = LoginUseCase(mockAuthRepository, mockTokenSharedPrefs);
  });

  group('LoginUseCase', () {
    const String testToken = '185785828255';
    const String testContact = '9849943368';
    const String testPassword = 'bibek123';
    const LoginParams params =
        LoginParams(contact: testContact, password: testPassword);

    // Test case for successful login
    test('should return token when login is successful', () async {
      when(() => mockAuthRepository.loginStudent(testContact, testPassword))
          .thenAnswer((_) async => const Right(testToken));

      when(() => mockTokenSharedPrefs.saveToken(testToken))
          .thenAnswer((_) async => const Right(null));

      final result = await loginUseCase(params);

      expect(result, const Right(testToken));
      verify(() => mockTokenSharedPrefs.saveToken(testToken)).called(1);
    });

    // Test case for failed login due to API failure
    test('should return ApiFailure when login fails', () async {
      // Arrange
      const failure = ApiFailure(message: 'Login failed', statusCode: 500);
      when(() => mockAuthRepository.loginStudent(testContact, testPassword))
          .thenAnswer((_) async => const Left(failure));

      final result = await loginUseCase(params);

      expect(result, const Left(failure));
      verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
    });
  });
}
