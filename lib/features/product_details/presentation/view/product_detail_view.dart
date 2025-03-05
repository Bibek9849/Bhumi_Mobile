import 'dart:convert';

import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductEntity product;
  final TokenSharedPrefs tokenSharedPrefs;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.tokenSharedPrefs,
  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;

  double get totalPrice =>
      (double.tryParse(widget.product.price.toString()) ?? 0) * quantity;

  Future<void> placeOrder() async {
    final orderDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final userIdResult = await widget.tokenSharedPrefs.getUserId();
    String userId = "";
    userIdResult.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching user ID: ${failure.message}')),
        );
      },
      (id) {
        userId = id;
      },
    );

    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID is missing. Please log in.')),
      );
      return;
    }

    final orderData = {
      "cart": [
        {
          "_id": widget.product.productId,
          "quantity": quantity,
          "price": totalPrice
        }
      ],
      "userId": userId,
      "orderDate": orderDate,
      "totalPrice": totalPrice,
      "totalQuantity": quantity
    };

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/order/save'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order placed successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to place order: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Define a maximum content width to prevent the UI from stretching too wide on tablets
    const double maxContentWidth = 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.product_categoryId.categoryName),
      ),
      body: SafeArea(
        child: Center(
          // Constrain the content to a maximum width
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: OrientationBuilder(
              builder: (context, orientation) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ Product Image (Dynamic Sizing for Landscape & Portrait)
                      Center(
                        child: Image.network(
                          'http://10.0.2.2:3000/product_type_images/${widget.product.image}',
                          height:
                              orientation == Orientation.portrait ? 200 : 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ✅ Product Name & Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product.name,
                                  style: textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                Text(
                                  "Available in stock",
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.green,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.yellow, size: 16),
                                    Text(
                                      "4.9 (192)",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Rs ${widget.product.price}/K.G.",
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 1) quantity--;
                                      });
                                    },
                                    icon: const Icon(Icons.remove,
                                        color: Colors.white),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    '$quantity Kg',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ✅ Product Description
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          border: Border.all(
                              color: colorScheme.onSurface.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Description",
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              widget.product.description.isNotEmpty
                                  ? widget.product.description
                                  : "No description available for this product.",
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ✅ Checkout Button (Fix Overflow Issue)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: placeOrder,
                          child: const Text(
                            "Proceed to Checkout",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
