import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/app/usecase/usecase.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

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
    // Check for empty contact or password and return a failure immediately
    if (params.contact.isEmpty || params.password.isEmpty) {
      return const Left(
          ApiFailure(message: 'Contact or password cannot be empty'));
    }

    // Proceed with the login if inputs are valid
    final result =
        await repository.loginStudent(params.contact, params.password);

    return result.fold(
      (failure) => Left(failure), // If login fails, return the failure
      (token) {
        tokenSharedPrefs
            .saveToken(token); // Save the token if login is successful
        return Right(token); // Return the token if successful
      },
    );
  }
}
