import 'package:bhumi_mobile/app/usecase/usecase.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/profile/data/dto/update_student_profile_dto.dart';
import 'package:bhumi_mobile/features/profile/domain/entity/student_entity.dart';
import 'package:bhumi_mobile/features/profile/domain/repository/student_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStudentProfileUsecase
    implements UsecaseWithParams<StudentEntity, UpdateStudentProfileDTO> {
  final IStudentRepository studentRepository;

  UpdateStudentProfileUsecase({required this.studentRepository});

  @override
  Future<Either<Failure, StudentEntity>> call(
      UpdateStudentProfileDTO params) async {
    return await studentRepository.updateStudentProfile(params);
  }
}
