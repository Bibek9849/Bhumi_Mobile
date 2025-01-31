import 'dart:io';

import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:bhumi_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, void>> registerStudent(AuthEntity student) async {
    try {
      await _authRemoteDataSource.registerStudent(student);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginStudent(
      String contact, String password) async {
    try {
      final token = await _authRemoteDataSource.loginStudent(contact, password);
      return Right(token);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDataSource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
