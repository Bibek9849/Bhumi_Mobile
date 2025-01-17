import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginStudent(String contact, String password);

  Future<void> registerStudent(AuthEntity student);

  Future<AuthEntity> getCurrentUser();

  // Future<String> uploadProfilePicture(File file);
}
