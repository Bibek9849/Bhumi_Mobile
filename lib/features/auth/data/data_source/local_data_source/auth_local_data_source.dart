import 'dart:io';

import 'package:bhumi_mobile/core/network/hive_service.dart';
import 'package:bhumi_mobile/features/auth/data/data_source/auth_data_source.dart';
import 'package:bhumi_mobile/features/auth/data/model/auth_hive_model.dart';
import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    // Return Empty AuthEntity
    return Future.value(const AuthEntity(
      userId: "1",
      fullName: "",
      email: "",
      image: null,
      contact: "",
      address: "",
      password: "",
    ));
  }

  @override
  Future<String> loginStudent(String contact, String password) async {
    try {
      final user = await _hiveService.login(contact, password);
      return Future.value("Login successful");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerStudent(AuthEntity student) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(student);

      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }
}
