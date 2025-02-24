import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.product_categoryId.categoryName)),
      body: Center(
        child: Column(
          children: [
            Image.network(
              'http://10.0.2.2:3000/product_type_images/${product.image}', // ✅ Corrected string interpolation
            ), // Ensure ProductEntity has imageUrl
            Text(product.name),
            Text("\$${product.price}"),
          ],
        ),
      ),
    );
  }
}
