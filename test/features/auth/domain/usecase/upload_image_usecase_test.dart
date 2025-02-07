import 'dart:io';

import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository repository;
  late UploadImageUsecase usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = UploadImageUsecase(repository);
  });

  final tFile = File('path/to/file.jpg');
  const tUploadResult = 'image_url_from_server';

  test('should upload image and return the image URL', () async {
    when(() => repository.uploadProfilePicture(tFile))
        .thenAnswer((_) async => const Right(tUploadResult));

    final result = await usecase(UploadImageParams(file: tFile));

    expect(result, const Right(tUploadResult));
    verify(() => repository.uploadProfilePicture(tFile)).called(1);
  });

  test('should return failure if image upload fails', () async {
    const failure = ApiFailure(message: 'Image upload failed');
    when(() => repository.uploadProfilePicture(tFile))
        .thenAnswer((_) async => const Left(failure));

    final result = await usecase(UploadImageParams(file: tFile));

    expect(result, const Left(failure));
    verify(() => repository.uploadProfilePicture(tFile)).called(1);
  });
}
