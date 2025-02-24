import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';

abstract interface class IProductDataSource {
  Future<List<ProductEntity>> getProducts();
  Future<void> createProduct(ProductEntity product);
  Future<void> deleteProduct(String id, String? token);
}
