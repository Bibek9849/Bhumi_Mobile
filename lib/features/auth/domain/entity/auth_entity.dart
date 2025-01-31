import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fullName;
  final String? image;
  final String email;
  final String contact;
  final String address;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fullName,
    required this.contact,
    required this.address,
    this.image,
    required this.password,
    required this.email,
  });

  @override
  List<Object?> get props =>
      [userId, fullName, image, email, contact, address, password];
}
