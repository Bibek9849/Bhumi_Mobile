import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:bhumi_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String fullName;
  final String email;
  final String contact;
  final String address;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.fullName,
    required this.email,
    required this.contact,
    required this.address,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props =>
      [fullName, email, image, contact, address, password];
}

class RegisterUserUseCase {
  final IAuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fullName: params.fullName,
      email: params.email,
      contact: params.contact,
      address: params.address,
      password: params.password,
      image: params.image,
    );
    return repository.registerStudent(authEntity);
  }
}
