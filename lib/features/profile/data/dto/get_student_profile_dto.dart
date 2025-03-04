import 'package:bhumi_mobile/features/profile/domain/entity/student_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_student_profile_dto.g.dart';

@JsonSerializable()
class GetStudentProfileDTO {
  final String message;
  final StudentProfileDTO student;

  GetStudentProfileDTO({
    required this.message,
    required this.student,
  });

  factory GetStudentProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$GetStudentProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetStudentProfileDTOToJson(this);
}

@JsonSerializable()
class StudentProfileDTO {
  final String? userId;
  final String fullName;
  final String? image;
  final String email;
  final String contact;
  final String address;

  StudentProfileDTO({
    this.userId,
    required this.fullName,
    required this.image,
    required this.email,
    required this.contact,
    required this.address,
  });

  factory StudentProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$StudentProfileDTOToJson(this);

  StudentEntity toEntity() {
    return StudentEntity(
      userId: userId,
      fullName: fullName,
      image: image,
      email: email,
      contact: contact,
      address: address,
    );
  }
}
