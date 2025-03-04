import 'package:bhumi_mobile/features/auth/data/model/auth_api_model.dart';
import 'package:bhumi_mobile/features/product_details/domain/entity/order_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class OrderApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? orderId;
  final AuthApiModel? userId;
  final String date;
  final String total_amount;
  final String total_quantity;
  final String? status;

  const OrderApiModel({
    this.orderId,
    this.userId,
    required this.date,
    required this.total_amount,
    required this.total_quantity,
    this.status,
  });

  // ✅ Convert API Model to Entity
  OrderEntity toEntity() {
    return OrderEntity(
      orderId: orderId,
      userId: userId?.toEntity(),
      date: date,
      total_amount: total_amount,
      total_quantity: total_quantity,
      status: status,
    );
  }

  // ✅ Convert Entity to API Model
  factory OrderApiModel.fromEntity(OrderEntity entity) {
    return OrderApiModel(
      orderId: entity.orderId,
      userId: entity.userId != null
          ? AuthApiModel.fromEntity(entity.userId!)
          : null,
      date: entity.date,
      total_amount: entity.total_amount,
      total_quantity: entity.total_quantity,
      status: entity.status,
    );
  }

  // ✅ JSON Serialization
  // factory OrderApiModel.fromJson(Map<String, dynamic> json) =>
  //     _$OrderApiModelFromJson(json);
  // Map<String, dynamic> toJson() => _$OrderApiModelToJson(this);

  @override
  List<Object?> get props =>
      [orderId, userId, date, total_amount, total_quantity, status];
}
