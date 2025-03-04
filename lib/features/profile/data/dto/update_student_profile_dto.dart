import 'package:json_annotation/json_annotation.dart';

part 'update_student_profile_dto.g.dart';

@JsonSerializable()
class UpdateStudentProfileDTO {
  final String? fullName;
  final String? email;
  final String? contact;
  final String? address;
  final String? image; // Optional

  UpdateStudentProfileDTO({
    this.fullName,
    this.email,
    this.contact,
    this.address,
    this.image,
  });

  factory UpdateStudentProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateStudentProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateStudentProfileDTOToJson(this);
}
