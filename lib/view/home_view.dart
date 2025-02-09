// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   final List<String> categories = ["All", "Vegetables", "Fruits", "Spice"];

//   final List<Map<String, String>> products = [
//     {
//       "name": "Broccoli",
//       "price": "NPR: 16.00/kg",
//       "image": "assets/images/bro.jpeg", // Add actual image paths
//     },
//     {
//       "name": "Tomato",
//       "price": "NPR: 8.00/kg",
//       "image": "assets/images/tom.jpeg",
//     },
//     {
//       "name": "Broccoli",
//       "price": "NPR: 16.00/kg",
//       "image": "assets/images/bro.jpeg",
//     },
//   ];

//   HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Profile Row (Image on Left)
//                 const Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20,
//                       backgroundImage:
//                           AssetImage("assets/images/home.png"), // Profile Image
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 10),

//                 // Welcome Message
//                 const Text(
//                   "Welcome,\nBibek Pandey",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),

//                 // Search Bar
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search vegetables..",
//                       border: InputBorder.none,
//                       prefixIcon: Icon(Icons.search, color: Colors.grey),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Categories
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: categories.map((category) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 6),
//                         child: Chip(
//                           label: Text(category),
//                           backgroundColor: category == "All"
//                               ? Colors.green
//                               : Colors.grey[200],
//                           labelStyle: TextStyle(
//                             color:
//                                 category == "All" ? Colors.white : Colors.black,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // Product Section
//                 const Text("Our Products",
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),

//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: products.map((product) {
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 12),
//                         child: ProductCard(
//                           name: product["name"]!,
//                           price: product["price"]!,
//                           image: product["image"]!, // Show Product Image
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Promotions
//                 const Text("Promo untukmu",
//                     style:
//                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("Discount 50%",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold)),
//                       const Text("SPESIAL PENGGUNA BARU",
//                           style: TextStyle(color: Colors.white, fontSize: 16)),
//                       const SizedBox(height: 8),
//                       ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             foregroundColor: Colors.green),
//                         child: const Text("Claim voucher"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Product Card Widget
// class ProductCard extends StatelessWidget {
//   final String name;
//   final String price;
//   final String image; // Image Parameter

//   const ProductCard(
//       {super.key,
//       required this.name,
//       required this.price,
//       required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 120,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 5,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Image.asset(image, height: 60, fit: BoxFit.cover), // Display Image
//           const SizedBox(height: 8),
//           Text(name,
//               style:
//                   const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//           Text(price,
//               style: const TextStyle(fontSize: 12, color: Colors.green)),
//           const SizedBox(height: 8),
//           ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green,
//               shape: const CircleBorder(),
//             ),
//             child: const Icon(Icons.add, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }
