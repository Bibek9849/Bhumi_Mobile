import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/profile/data/data_source/student_remote_data_source.dart/student_remote_data_source.dart';
import 'package:bhumi_mobile/features/profile/data/dto/update_student_profile_dto.dart';
import 'package:bhumi_mobile/features/profile/domain/entity/student_entity.dart';
import 'package:bhumi_mobile/features/profile/domain/repository/student_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class StudentRemoteRepository implements IStudentRepository {
  final StudentRemoteDataSource _studentRemoteDataSource;

  StudentRemoteRepository(this._studentRemoteDataSource);

  @override
  Future<Either<Failure, StudentEntity>> getStudentProfile() async {
    try {
      debugPrint("Fetching student profile...");
      final student = await _studentRemoteDataSource.getStudentProfile();
      return Right(student);
    } catch (e) {
      debugPrint("Error fetching student profile: $e");
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudentEntity>> updateStudentProfile(
      UpdateStudentProfileDTO updatedData) async {
    try {
      final student =
          await _studentRemoteDataSource.updateStudentProfile(updatedData);
      return Right(student);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
