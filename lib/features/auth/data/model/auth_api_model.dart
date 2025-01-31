import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fullName;
  final String email;
  final String? image;
  final String contact;
  final String address;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.image,
    required this.contact,
    required this.address,
    required this.password,
  });

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      fullName: fullName,
      email: email,
      image: image,
      contact: contact,
      address: address,
      password: password ?? '',
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fullName: entity.fullName,
      email: entity.email,
      image: entity.image,
      contact: entity.contact,
      address: entity.address,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props =>
      [id, fullName, email, image, contact, address, password];
}
