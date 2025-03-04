import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  // ✅ Save Token
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // ✅ Get Token
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // ✅ Save User ID
  Future<Either<Failure, void>> saveUserId(String userId) async {
    try {
      await _sharedPreferences.setString('userId', userId);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // ✅ Get User ID
  Future<Either<Failure, String>> getUserId() async {
    try {
      final userId = _sharedPreferences.getString('userId');
      return Right(userId ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // ✅ Save Full Name
  Future<Either<Failure, void>> saveUserFullName(String fullName) async {
    try {
      await _sharedPreferences.setString('fullName', fullName);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // ✅ Get Full Name
  Future<Either<Failure, String>> getUserFullName() async {
    try {
      final fullName = _sharedPreferences.getString('fullName');
      return Right(fullName ?? '');
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // ✅ Save User Contact
  Future<Either<Failure, void>> saveUserContact(String contact) async {
    try {
      await _sharedPreferences.setString('contact', contact);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // ✅ Get User Contact
  Future<Either<Failure, String>> getUserContact() async {
    try {
      final contact = _sharedPreferences.getString('contact');
      return Right(contact ?? 'Not Provided'); // Default if missing
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // ✅ Save User Profile Image
  Future<Either<Failure, void>> saveUserImage(String imageUrl) async {
    try {
      await _sharedPreferences.setString('profileImage', imageUrl);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // ✅ Get User Profile Image
  // ✅ Get User Profile Image
  Future<Either<Failure, String>> getUserImage() async {
    try {
      final imageUrl = _sharedPreferences.getString('profileImage');

      return Right((imageUrl != null &&
                  imageUrl.isNotEmpty &&
                  imageUrl.startsWith("http"))
              ? imageUrl
              : "https://i.pravatar.cc/150?img=3" // ✅ Default placeholder
          );
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
