import 'package:bhumi_mobile/app/constants/api_endpoints.dart';
import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/profile/data/data_source/student_data_source.dart';
import 'package:bhumi_mobile/features/profile/data/dto/get_student_profile_dto.dart';
import 'package:bhumi_mobile/features/profile/data/dto/update_student_profile_dto.dart';
import 'package:bhumi_mobile/features/profile/data/model/student_api_model.dart';
import 'package:bhumi_mobile/features/profile/domain/entity/student_entity.dart';
import 'package:dio/dio.dart';

class StudentRemoteDataSource implements IStudentDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;

  StudentRemoteDataSource({
    required Dio dio,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _dio = dio,
        _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<StudentEntity> getStudentProfile() async {
    try {
      //  Get the stored JWT token
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found in shared prefs");
      }

      // Send API request with Authorization header
      final response = await _dio.get(
        ApiEndpoints.getStudentProfile,
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // Send JWT token
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['student'] == null) {
          throw const ApiFailure(message: "No student profile data found.");
        }
        final studentApiModel = StudentApiModel.fromJson(data['student']);

        return studentApiModel.toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    } catch (e) {
      throw Exception("Something went wrong (StudentRemoteDataSource): $e");
    }
  }

  @override
  Future<StudentEntity> updateStudentProfile(
      UpdateStudentProfileDTO updatedData) async {
    try {
      //  Get the stored JWT token
      final tokenResult = await _tokenSharedPrefs.getToken();
      final token = tokenResult.fold((failure) => null, (token) => token);

      if (token == null || token.isEmpty) {
        throw Exception("Token not found in shared prefs");
      }
      FormData formData = FormData();

      if (updatedData.image != null && updatedData.image!.isNotEmpty) {
        formData.files.add(MapEntry(
          "image",
          await MultipartFile.fromFile(updatedData.image!,
              filename: "profile.jpg"),
        ));
      }
      formData.fields.addAll([
        if (updatedData.fullName != null)
          MapEntry("fullName", updatedData.fullName!),
        if (updatedData.email != null) MapEntry("email", updatedData.email!),
        if (updatedData.contact != null)
          MapEntry("contact", updatedData.contact!),
      ]);

      final response = await _dio.put(
        ApiEndpoints.getStudentProfile,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        final data = GetStudentProfileDTO.fromJson(response.data);
        return data.student.toEntity();
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }
}
