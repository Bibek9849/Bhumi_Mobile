import 'package:bhumi_mobile/features/product_details/domain/entity/order_entity.dart';

abstract interface class IOrderDataSource {
  Future<void> saveOrder(OrderEntity order);
}
