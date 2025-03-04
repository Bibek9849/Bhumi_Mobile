import 'package:bhumi_mobile/app/usecase/usecase.dart';
import 'package:bhumi_mobile/core/error/failure.dart';
import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:bhumi_mobile/features/product_details/domain/entity/order_entity.dart';
import 'package:bhumi_mobile/features/product_details/domain/repository/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class OrderParams extends Equatable {
  final AuthEntity? userId;
  final String date;
  final String total_amount;
  final String total_quantity;
  final String? status;

  const OrderParams({
    this.userId,
    required this.date,
    required this.total_amount,
    required this.total_quantity,
    this.status,
  });

  //Initial Const
  const OrderParams.initial({
    this.userId,
    required this.date,
    required this.total_amount,
    required this.total_quantity,
    this.status,
  });
  @override
  List<Object?> get props =>
      [userId, date, total_amount, total_quantity, status];
}

class OrderUserUsecase implements UsecaseWithParams<void, OrderParams> {
  final IOrderRepository repository;
  OrderUserUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(OrderParams params) {
    final orderEntity = OrderEntity(
      userId: params.userId,
      date: params.date,
      total_amount: params.total_amount,
      total_quantity: params.total_quantity,
      status: params.status,
    );
    return repository.saveOrders(orderEntity);
  }
}
