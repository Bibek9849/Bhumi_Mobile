import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:bhumi_mobile/features/product_details/domain/entity/order_entity.dart';
import 'package:equatable/equatable.dart';

class DetailEntity extends Equatable {
  final String? detailsId;
  final OrderEntity orderId;
  final ProductEntity productID;
  final String total_quantity;
  final String sub_total;

  const DetailEntity({
    required this.detailsId,
    required this.orderId,
    required this.productID,
    required this.total_quantity,
    required this.sub_total,
  });

  @override
  List<Object?> get props => [
        detailsId,
        orderId,
        productID,
        total_quantity,
        sub_total,
      ];
}
