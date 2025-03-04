import 'package:bhumi_mobile/features/profile/domain/entity/student_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'student_api_model.g.dart';

@JsonSerializable()
class StudentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String fullName;
  final String email;
  final String contact;
  final String? image;
  final String address;

  const StudentApiModel({
    this.userId,
    required this.fullName,
    required this.email,
    required this.contact,
    this.image,
    required this.address,
  });

  /// **Convert from JSON**
  factory StudentApiModel.fromJson(Map<String, dynamic> json) =>
      _$StudentApiModelFromJson(json);

  /// **Convert to JSON**
  Map<String, dynamic> toJson() => _$StudentApiModelToJson(this);

  /// **Convert to Domain Entity**
  StudentEntity toEntity() {
    return StudentEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      contact: contact,
      image: image ?? "",
      address: address,
    );
  }

  /// **Convert from Domain Entity**
  factory StudentApiModel.fromEntity(StudentEntity entity) {
    return StudentApiModel(
      userId: entity.userId,
      fullName: entity.fullName,
      email: entity.email,
      contact: entity.contact,
      image: entity.image,
      address: entity.address,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        fullName,
        email,
        contact,
        image,
        address,
      ];
}
