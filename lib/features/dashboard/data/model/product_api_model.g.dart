// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      productId: json['_id'] as String?,
      product_categoryId: CategoryApiModel.fromJson(
          json['product_categoryId'] as Map<String, dynamic>),
      name: json['name'] as String,
      image: json['image'] as String?,
      price: json['price'] as String,
      quantity: json['quantity'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.productId,
      'product_categoryId': instance.product_categoryId,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price,
      'quantity': instance.quantity,
      'description': instance.description,
    };
