import 'package:equatable/equatable.dart';

class StudentEntity extends Equatable {
  final String? userId;
  final String fullName;
  final String? image;
  final String email;
  final String contact;
  final String address;

  const StudentEntity({
    this.userId,
    required this.fullName,
    required this.contact,
    required this.address,
    this.image,
    required this.email,
  });

  @override
  List<Object?> get props => [userId, fullName, image, email, contact, address];

  // ✅ Convert API JSON Response to StudentEntity
  factory StudentEntity.fromJson(Map<String, dynamic> json) {
    return StudentEntity(
      userId: json['id'], // Ensure it matches API response key
      fullName: json['fullName'],
      image: json['image'] != null
          ? "http://10.0.2.2:3000/public/uploads/${json['image']}"
          : null, // ✅ Convert image path
      email: json['email'],
      contact: json['contact'],
      address: json['address'] ?? "Not Provided",
    );
  }

  // ✅ Convert StudentEntity to JSON (for API requests)
  Map<String, dynamic> toJson() {
    return {
      "id": userId,
      "fullName": fullName,
      "image": image,
      "email": email,
      "contact": contact,
      "address": address,
    };
  }
}
