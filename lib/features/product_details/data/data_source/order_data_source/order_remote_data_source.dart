import 'package:bhumi_mobile/app/constants/api_endpoints.dart';
import 'package:bhumi_mobile/features/product_details/data/data_source/order_data_source.dart';
import 'package:bhumi_mobile/features/product_details/domain/entity/order_entity.dart';
import 'package:dio/dio.dart';

class OrderRemoteDataSource implements IOrderDataSource {
  final Dio _dio;
  OrderRemoteDataSource(this._dio);
  @override
  Future<void> saveOrder(OrderEntity order) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.saveOrder,
        data: {
          "userId": order.userId,
          "date": order.date,
          "total_amount": order.total_amount,
          "total_quantity": order.total_quantity,
          "status": order.status,
        },
      );

      if (response.statusCode == 201) {
        return;
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
