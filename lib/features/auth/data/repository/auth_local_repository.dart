import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:bhumi_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginStudent(
    String contact,
    String password,
  ) async {
    try {
      final token = await _authLocalDataSource.loginStudent(contact, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerStudent(AuthEntity student) async {
    try {
      return Right(_authLocalDataSource.registerStudent(student));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, String>> uploadProfilePicture(File file) async {
  //   // TODO: implement uploadProfilePicture
  //   throw UnimplementedError();
  // }
}
