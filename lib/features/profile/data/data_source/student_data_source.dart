import 'package:bhumi_mobile/features/profile/data/dto/update_student_profile_dto.dart';
import 'package:bhumi_mobile/features/profile/domain/entity/student_entity.dart';

abstract interface class IStudentDataSource {
  Future<StudentEntity> getStudentProfile();
  Future<StudentEntity> updateStudentProfile(
      UpdateStudentProfileDTO updatedData);
}
