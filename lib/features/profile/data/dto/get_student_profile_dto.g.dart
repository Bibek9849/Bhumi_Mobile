// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_student_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetStudentProfileDTO _$GetStudentProfileDTOFromJson(
        Map<String, dynamic> json) =>
    GetStudentProfileDTO(
      message: json['message'] as String,
      student:
          StudentProfileDTO.fromJson(json['student'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetStudentProfileDTOToJson(
        GetStudentProfileDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'student': instance.student,
    };

StudentProfileDTO _$StudentProfileDTOFromJson(Map<String, dynamic> json) =>
    StudentProfileDTO(
      userId: json['userId'] as String?,
      fullName: json['fullName'] as String,
      image: json['image'] as String?,
      email: json['email'] as String,
      contact: json['contact'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$StudentProfileDTOToJson(StudentProfileDTO instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'image': instance.image,
      'email': instance.email,
      'contact': instance.contact,
      'address': instance.address,
    };
