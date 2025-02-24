import 'package:bhumi_mobile/app/constants/api_endpoints.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/dashboard/data/data_source/product_data_source.dart';
import 'package:bhumi_mobile/features/dashboard/data/dto/get_all_product_dto.dart';
import 'package:bhumi_mobile/features/dashboard/data/model/product_api_model.dart';
import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProductRemoteDataSource implements IProductDataSource {
  final Dio _dio;

  ProductRemoteDataSource({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllProduct);

      if (response.statusCode == 200) {
        // Check if response.data is a list instead of a map
        if (response.data is List) {
          // Manually construct a map with a dummy `success` and `count`
          Map<String, dynamic> jsonData = {
            "success": true,
            "count": response.data.length,
            "data": response.data
          };

          GetAllProductDTO getAllProductDTO =
              GetAllProductDTO.fromJson(jsonData);
          return ProductApiModel.toEntityList(getAllProductDTO.data);
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Either<Failure, void>> createProduct(ProductEntity product) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id, String? token) {
    throw UnimplementedError();
  }
}
