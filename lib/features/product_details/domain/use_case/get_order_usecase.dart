import 'package:bhumi_mobile/app/usecase/usecase.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/product_details/domain/entity/order_entity.dart';
import 'package:bhumi_mobile/features/product_details/domain/repository/order_repository.dart';
import 'package:dartz/dartz.dart';

class GetOrderUsecase implements UsecaseWithoutParams<List<OrderEntity>> {
  final IOrderRepository orderRepository;

  GetOrderUsecase({required this.orderRepository});

  @override
  Future<Either<Failure, List<OrderEntity>>> call() async {
    final response = await orderRepository.getOrders();

    response.fold(
      (failure) => print("UseCase Error: ${failure.message}"),
      (orders) {
        print("UseCase Fetched ${orders.length} orders");
        for (var order in orders) {}
      },
    );

    return response;
  }
}
