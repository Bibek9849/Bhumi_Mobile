import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fullName;
  final String contact;
  final String address;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fullName,
    required this.contact,
    required this.address,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, fullName, contact, address, password];
}
