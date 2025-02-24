import 'package:bhumi_mobile/app/constants/api_endpoints.dart';
import 'package:bhumi_mobile/features/category/data/model/category_api_model.dart';
import 'package:bhumi_mobile/features/category/data/data_source/category_data_source.dart';
import 'package:bhumi_mobile/features/category/data/dto/get_all_category_dto.dart';
import 'package:bhumi_mobile/features/category/domain/entity/category_entity.dart';
import 'package:dio/dio.dart';

class CategoryRemoteDataSource implements ICategoryDataSource {
  final Dio _dio;

  CategoryRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllCategory);
      if (response.statusCode == 200) {
        GetAllCategoryDto categoryDto =
            GetAllCategoryDto.fromJson(response.data);
        return CategoryApiModel.toEntityList(categoryDto.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
