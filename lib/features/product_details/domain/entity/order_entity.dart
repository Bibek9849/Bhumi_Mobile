import 'package:bhumi_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? orderId;
  final AuthEntity? userId;
  final String date;
  final String total_amount;
  final String total_quantity;
  final String? status;

  const OrderEntity({
    this.orderId,
    this.userId,
    required this.date,
    required this.total_amount,
    required this.total_quantity,
    this.status,
  });

  @override
  List<Object?> get props =>
      [orderId, userId, date, total_amount, total_quantity, status];
}
