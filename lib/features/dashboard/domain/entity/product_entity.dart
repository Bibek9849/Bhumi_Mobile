import 'package:bhumi_mobile/features/category/domain/entity/category_entity.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? productId;
  final CategoryEntity product_categoryId;
  final String name;
  final String? image;
  final String price;
  final String quantity;
  final String description;

  const ProductEntity({
    required this.productId,
    required this.product_categoryId,
    required this.name,
    this.image,
    required this.price,
    required this.quantity,
    required this.description,
  });

  @override
  List<Object?> get props => [
        productId,
        product_categoryId,
        name,
        image,
        price,
        quantity,
        description
      ];
}
