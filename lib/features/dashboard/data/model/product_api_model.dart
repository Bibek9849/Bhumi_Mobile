// import 'package:bhumi_mobile/features/category/data/category_api_model.dart';
// import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'product_api_model.g.dart';

// @JsonSerializable()
// class ProductApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? productId;
//   final CategoryApiModel product_categoryId;
//   final String name;
//   final String? image;
//   final String price;
//   final String quantity;
//   final String description;

//   const ProductApiModel({
//     this.productId,
//     required this.product_categoryId,
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.quantity,
//     required this.description,
//   });

//   // const ProductApiModel.empty()
//   //     : productId = '',
//   //       categoryId = '';
//   //       name = '';
//   //       categoryId = '';
//   //       categoryId = '';
//   //       categoryId = '';
//   //       categoryId = '';

//   // From Json , write full code without generator
//   factory ProductApiModel.fromJson(Map<String, dynamic> json) {
//     return ProductApiModel(
//       productId: json['_id'],
//       product_categoryId: json['product_categoryId'],
//       name: json['name'],
//       image: json['image'],
//       price: json['price'],
//       quantity: json['quantity'],
//       description: json['description'],
//     );
//   }

//   // To Json , write full code without generator
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': productId,
//       'product_categoryId': product_categoryId,
//       'name': name,
//       'image': image,
//       'price': price,
//       'quantity': quantity,
//       'description': description,
//     };
//   }
//   factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
//       _$ProductApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

//   // Convert API Object to Entity
//   ProductEntity toEntity() => ProductEntity(
//         productId: productId,
//         product_categoryId: product_categoryId.toEntity(),
//         name: name,
//         image: image,
//         price: price,
//         quantity: quantity,
//         description: description,
//       );

//   // Convert Entity to API Object
//   static ProductApiModel fromEntity(ProductEntity entity) => ProductApiModel(
//         product_categoryId:
//             CategoryApiModel.fromEntity(entity.product_categoryId),
//         name: entity.name,
//         image: entity.image,
//         price: entity.price,
//         quantity: entity.quantity,
//         description: entity.description,
//       );

//   // Convert API List to Entity List
//   static List<ProductEntity> toEntityList(List<ProductApiModel> models) =>
//       models.map((model) => model.toEntity()).toList();

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

import 'package:bhumi_mobile/features/category/data/model/category_api_model.dart';
import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_api_model.g.dart';

@JsonSerializable()
class ProductApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? productId;
  @JsonKey(nullable: true)
  final CategoryApiModel product_categoryId;
  @JsonKey(nullable: true)
  final String name;
  @JsonKey(nullable: true)
  final String? image;
  @JsonKey(nullable: true)
  final String price;
  @JsonKey(nullable: true)
  final String quantity;
  @JsonKey(nullable: true)
  final String description;

  const ProductApiModel({
    this.productId,
    required this.product_categoryId,
    required this.name,
    this.image,
    required this.price,
    required this.quantity,
    required this.description,
  });

  /// **Factory constructor to create an instance from JSON**
  factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProductApiModelFromJson(json);

  /// **Method to convert object to JSON**
  Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

  /// **Convert API Model to Entity**
  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      product_categoryId: product_categoryId.toEntity(),
      name: name,
      image: image,
      price: price,
      quantity: quantity,
      description: description,
    );
  }

  /// **Convert Entity to API Model**
  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
      productId: entity.productId,
      product_categoryId:
          CategoryApiModel.fromEntity(entity.product_categoryId),
      name: entity.name,
      image: entity.image,
      price: entity.price,
      quantity: entity.quantity,
      description: entity.description,
    );
  }

  /// **Convert API List to Entity List**
  static List<ProductEntity> toEntityList(List<ProductApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [
        productId,
        product_categoryId,
        name,
        image,
        price,
        quantity,
        description,
      ];
}
