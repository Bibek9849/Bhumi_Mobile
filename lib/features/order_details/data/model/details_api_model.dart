// import 'package:bhumi_mobile/features/category/data/model/category_api_model.dart';
// import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
// import 'package:bhumi_mobile/features/order_details/domain/entity/detail_entity.dart';
// import 'package:bhumi_mobile/features/product_details/domain/entity/order_entity.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'product_api_model.g.dart';

// @JsonSerializable()
// class DetailsApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? detailsId;
//   @JsonKey(nullable: true)
//   final OrderEntity orderId;
//   @JsonKey(nullable: true)
//   final ProductEntity productID;
//   @JsonKey(nullable: true)
//   final String total_quantity;
//   @JsonKey(nullable: true)
//   final String sub_total;

//   const DetailsApiModel({
//     this.detailsId,
//     required this.orderId,
//     required this.productID,
//     required this.total_quantity,
//     required this.sub_total,
//   });

//   /// **Factory constructor to create an instance from JSON**
//   factory DetailsApiModel.fromJson(Map<String, dynamic> json) =>
//       _$DetailsApiModelFromJson(json);

//   /// **Method to convert object to JSON**
//   Map<String, dynamic> toJson() => _$DetailsApiModelToJson(this);

//   /// **Convert API Model to Entity**
//   DetailEntity toEntity() {
//     return DetailEntity(
//       detailsId: detailsId,
//       orderId: orderId.toEntity(),
//       productID: productID.toEntity(),
//       total_quantity: total_quantity,
//       sub_total: sub_total,

//     );
//   }

//   /// **Convert Entity to API Model**
//   factory DetailsApiModel.fromEntity(DetailEntity entity) {
//     return DetailsApiModel(
//       detailsId: entity.detailsId,
//       orderId:OrderApiModel.fromEntity(entity.orderId):
//       productID: .fromEntity(entity.product_categoryId),
//       name: entity.name,
//       image: entity.image,
//       price: entity.price,
//       quantity: entity.quantity,
//       description: entity.description,
//     );
//   }

//   /// **Convert API List to Entity List**
//   static List<ProductEntity> toEntityList(List<ProductApiModel> models) {
//     return models.map((model) => model.toEntity()).toList();
//   }

//   @override
//   List<Object?> get props => [
//         productId,
//         product_categoryId,
//         name,
//         image,
//         price,
//         quantity,
//         description,
//       ];
// }
