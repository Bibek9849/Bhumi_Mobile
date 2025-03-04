import 'package:bhumi_mobile/app/usecase/usecase.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/profile/domain/entity/student_entity.dart';
import 'package:bhumi_mobile/features/profile/domain/repository/student_repository.dart';
import 'package:dartz/dartz.dart';

class GetStudentProfileUsecase implements UsecaseWithoutParams<StudentEntity> {
  final IStudentRepository repository;

  GetStudentProfileUsecase({required this.repository});

  @override
  Future<Either<Failure, StudentEntity>> call() async {
    return await repository.getStudentProfile();
  }
}
