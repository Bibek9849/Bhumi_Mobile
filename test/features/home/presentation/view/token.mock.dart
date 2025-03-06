import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class FakeTokenSharedPrefs implements TokenSharedPrefs {
  String _token = '';
  String _userId = '';
  String _fullName = '';
  String _contact = '';
  String _imageUrl = '';

  @override
  Future<Either<Failure, void>> saveToken(String token) async {
    _token = token;
    return const Right(null);
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    return Right(_token);
  }

  @override
  Future<Either<Failure, void>> saveUserId(String userId) async {
    _userId = userId;
    return const Right(null);
  }

  @override
  Future<Either<Failure, String>> getUserId() async {
    return Right(_userId);
  }

  @override
  Future<Either<Failure, void>> saveUserFullName(String fullName) async {
    _fullName = fullName;
    return const Right(null);
  }

  @override
  Future<Either<Failure, String>> getUserFullName() async {
    return Right(_fullName);
  }

  @override
  Future<Either<Failure, void>> saveUserContact(String contact) async {
    _contact = contact;
    return const Right(null);
  }

  @override
  Future<Either<Failure, String>> getUserContact() async {
    return Right(_contact.isNotEmpty ? _contact : 'Not Provided');
  }

  @override
  Future<Either<Failure, void>> saveUserImage(String imageUrl) async {
    _imageUrl = imageUrl;
    return const Right(null);
  }

  @override
  Future<Either<Failure, String>> getUserImage() async {
    if (_imageUrl.isNotEmpty && _imageUrl.startsWith("http")) {
      return Right(_imageUrl);
    }
    return const Right("assets/images/profile.jpg");
  }
}
