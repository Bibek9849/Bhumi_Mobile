import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/app/usecase/usecase.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginParams extends Equatable {
  final String contact;
  final String password;

  const LoginParams({
    required this.contact,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : contact = '',
        password = '';

  @override
  List<Object> get props => [contact, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    final result =
        await repository.loginStudent(params.contact, params.password);
    return result.fold(
      (failure) => Left(failure),
      (token) async {
        await tokenSharedPrefs.saveToken(token); // ✅ Save Token

        // ✅ Decode JWT Token to Extract User Data
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        String? userId = decodedToken['id'];
        String? fullName = decodedToken['fullName'];
        String? contact = decodedToken['contact'];
        String? profileImage = decodedToken['profileImage'];

        // ✅ Save User Data in Shared Preferences
        if (userId != null) await tokenSharedPrefs.saveUserId(userId);
        if (fullName != null) await tokenSharedPrefs.saveUserFullName(fullName);
        if (contact != null) await tokenSharedPrefs.saveUserContact(contact);
        if (profileImage != null)
          await tokenSharedPrefs.saveUserImage(profileImage);

        return Right(token);
      },
    );
  }
}
