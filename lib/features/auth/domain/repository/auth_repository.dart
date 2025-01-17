import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerStudent(AuthEntity student);

  Future<Either<Failure, String>> loginStudent(String contact, String password);

  // Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
