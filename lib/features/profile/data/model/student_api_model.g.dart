// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentApiModel _$StudentApiModelFromJson(Map<String, dynamic> json) =>
    StudentApiModel(
      userId: json['_id'] as String?,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      contact: json['contact'] as String,
      image: json['image'] as String?,
      address: json['address'] as String,
    );

Map<String, dynamic> _$StudentApiModelToJson(StudentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'fullName': instance.fullName,
      'email': instance.email,
      'contact': instance.contact,
      'image': instance.image,
      'address': instance.address,
    };
