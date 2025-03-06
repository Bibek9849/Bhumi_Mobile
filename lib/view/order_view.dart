// import 'dart:convert';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class OrderView extends StatefulWidget {
//   const OrderView({super.key});

//   @override
//   _OrderViewState createState() => _OrderViewState();
// }

// class _OrderViewState extends State<OrderView>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   List<Map<String, dynamic>> orders = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//     fetchOrders();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> fetchOrders() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://10.0.2.2:3000/api/details/show'),
//         headers: {"Content-Type": "application/json"},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           orders = List<Map<String, dynamic>>.from(data["data"]);
//           isLoading = false;
//         });
//       } else {
//         print("Error: ${response.body}");
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Fetch Error: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildOrderList("All"),
//                 _buildOrderList("To Pay"),
//                 _buildOrderList("To Ship"),
//                 _buildOrderList("To Receive"),
//               ],
//             ),
//     );
//   }

//   Widget _buildOrderList(String filterStatus) {
//     List<Map<String, dynamic>> filteredOrders = filterStatus == "All"
//         ? orders
//         : orders
//             .where((order) => order["orderId"]["status"] == filterStatus)
//             .toList();

//     if (filteredOrders.isEmpty) {
//       return const Center(
//         child: Text(
//           "No Orders Found",
//           style: TextStyle(fontSize: 16, color: Colors.grey),
//         ),
//       );
//     }

//     return ListView.builder(
//       itemCount: filteredOrders.length,
//       itemBuilder: (context, index) {
//         return _buildOrderItem(filteredOrders[index]);
//       },
//     );
//   }

//   Widget _buildOrderItem(Map<String, dynamic> order) {
//     // Prepend base URL to the product image
//     final imageUrl =
//         'http://10.0.2.2:3000/product_type_images/${order["productID"]["image"]}';

//     return GestureDetector(
//       onTap: () {
//         _showOrderDetails(order);
//       },
//       child: Card(
//         margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         elevation: 2,
//         child: Padding(
//           padding: const EdgeInsets.all(14),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CachedNetworkImage(
//                 imageUrl: imageUrl,
//                 width: 70,
//                 height: 70,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) =>
//                     const CircularProgressIndicator(),
//                 errorWidget: (context, url, error) => const Icon(
//                   Icons.image_not_supported,
//                   size: 70,
//                   color: Colors.grey,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       order["productID"]["name"],
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 14),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "Rs. ${order["sub_total"]}  |  Qty: ${order["total_quantity"]}",
//                       style:
//                           const TextStyle(color: Colors.black87, fontSize: 14),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "#${order["_id"]}",
//                       style: const TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: _getStatusColor(order["orderId"]["status"]),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       order["orderId"]["status"],
//                       style: const TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => _deleteOrder(order["_id"]),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _deleteOrder(String orderId) async {
//     try {
//       final response = await http.delete(
//         Uri.parse('http://10.0.2.2:3000/api/details/$orderId'),
//         headers: {"Content-Type": "application/json"},
//       );

//       if (response.statusCode == 200) {
//         setState(() {
//           orders.removeWhere((order) => order["_id"] == orderId);
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Order deleted successfully!")),
//         );
//       } else {
//         print("Delete Error: ${response.body}");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: ${response.body}")),
//         );
//       }
//     } catch (e) {
//       print("Delete Exception: $e");
//     }
//   }

//   void _showOrderDetails(Map<String, dynamic> order) {
//     // Use the same base URL for the image
//     final imageUrl =
//         'http://10.0.2.2:3000/product_type_images/${order["productID"]["image"]}';

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Order Details - ${order["_id"]}"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CachedNetworkImage(
//                 imageUrl: imageUrl,
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 order["productID"]["name"],
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 5),
//               Text("Price: Rs. ${order["sub_total"]}"),
//               Text("Quantity: ${order["total_quantity"]}"),
//               Text("Status: ${order["orderId"]["status"]}"),
//               Text("Order Date: ${order["orderId"]["createdAt"]}"),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Close"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Color _getStatusColor(String status) {
//     switch (status) {
//       case "To Pay":
//         return Colors.red;
//       case "To Ship":
//         return Colors.orange;
//       case "To Receive":
//         return Colors.blue;
//       case "Completed":
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
// }
