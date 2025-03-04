// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_student_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStudentProfileDTO _$UpdateStudentProfileDTOFromJson(
        Map<String, dynamic> json) =>
    UpdateStudentProfileDTO(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      contact: json['contact'] as String?,
      address: json['address'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UpdateStudentProfileDTOToJson(
        UpdateStudentProfileDTO instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'contact': instance.contact,
      'address': instance.address,
      'image': instance.image,
    };
