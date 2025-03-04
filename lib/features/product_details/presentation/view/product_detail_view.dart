import 'dart:convert';

import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductEntity product;
  final TokenSharedPrefs tokenSharedPrefs; // Inject TokenSharedPrefs

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

    // Fetch user ID from SharedPreferences
    final userIdResult = await widget.tokenSharedPrefs.getUserId();

    // Handle possible error when fetching user ID
    String userId = "";
    userIdResult.fold(
      (failure) {
        print("Error fetching user ID: ${failure.message}");
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
        Uri.parse('http://10.0.2.2:3000/api/order/save'), // Ensure correct URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderData),
      );

      print("Response Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

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
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.product_categoryId.categoryName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'http://10.0.2.2:3000/product_type_images/${widget.product.image}',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Available in stock",
                      style: TextStyle(fontSize: 14, color: Colors.green),
                    ),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        Text("4.9 (192)",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Rs ${widget.product.price}/K.G.",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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
                          icon: const Icon(Icons.remove, color: Colors.white),
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                        Text('$quantity Kg',
                            style: const TextStyle(fontSize: 16)),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const Text("Invoice",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Original Price"),
                      Text("Rs ${widget.product.price}"),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("₹${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: placeOrder, // Calls the order API
                child: const Text(
                  "Proceed to Checkout",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
