import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:bhumi_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String fullName;
  final String contact;
  final String address;
  final String password;

  const RegisterUserParams({
    required this.fullName,
    required this.contact,
    required this.address,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, contact, address, password];
}

class RegisterUserUseCase {
  final IAuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fullName: params.fullName,
      contact: params.contact,
      address: params.address,
      password: params.password,
    );
    return repository.registerStudent(authEntity);
  }
}
