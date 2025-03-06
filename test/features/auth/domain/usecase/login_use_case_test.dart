import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/login_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Import your mock classes.
import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;
  late LoginUseCase loginUseCase;

  const String validTestToken = "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0."
      "eyJpZCI6IjEyMyIsImZ1bGxOYW1lIjoiVGVzdCBVc2VyIiwiY29udGFjdCI6Ijk4NDk5NDMzNjgiLCJwcm9maWxlSW1hZ2UiOiJodHRwOi8vZXhhbXBsZS5jb20vaW1hZ2UucG5nIn0.";

  const String testContact = '9849943368';
  const String testPassword = 'bibek123';
  const LoginParams params =
      LoginParams(contact: testContact, password: testPassword);

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    loginUseCase = LoginUseCase(mockAuthRepository, mockTokenSharedPrefs);
  });

  group('LoginUseCase', () {
    test('should return token when login is successful', () async {
      // Arrange
      when(() => mockAuthRepository.loginStudent(testContact, testPassword))
          .thenAnswer((_) async => const Right(validTestToken));
      when(() => mockTokenSharedPrefs.saveToken(validTestToken))
          .thenAnswer((_) async => const Right(null));
      // If additional user data is saved, mock those calls as well.
      when(() => mockTokenSharedPrefs.saveUserId(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockTokenSharedPrefs.saveUserFullName(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockTokenSharedPrefs.saveUserContact(any()))
          .thenAnswer((_) async => const Right(null));
      when(() => mockTokenSharedPrefs.saveUserImage(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, const Right(validTestToken));
      verify(() => mockTokenSharedPrefs.saveToken(validTestToken)).called(1);
    });

    test('should return ApiFailure when login fails', () async {
      // Arrange
      const failure = ApiFailure(message: 'Login failed', statusCode: 500);
      when(() => mockAuthRepository.loginStudent(testContact, testPassword))
          .thenAnswer((_) async => const Left(failure));

      // Act
      final result = await loginUseCase(params);

      // Assert
      expect(result, const Left(failure));
      verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
    });
  });
}
