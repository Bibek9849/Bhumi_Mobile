import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/profile/data/dto/update_student_profile_dto.dart';
import 'package:bhumi_mobile/features/profile/domain/entity/student_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IStudentRepository {
  Future<Either<Failure, StudentEntity>> getStudentProfile();
  Future<Either<Failure, StudentEntity>> updateStudentProfile(
      UpdateStudentProfileDTO updatedData);
}
