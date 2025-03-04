import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/product_details/domain/entity/order_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IOrderRepository {
  Future<Either<Failure, void>> saveOrders(OrderEntity order);
  Future<Either<Failure, List<OrderEntity>>> getOrders();
}
