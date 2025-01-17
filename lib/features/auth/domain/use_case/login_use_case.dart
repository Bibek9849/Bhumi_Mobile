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

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.loginStudent(params.contact, params.password);
  }
}
