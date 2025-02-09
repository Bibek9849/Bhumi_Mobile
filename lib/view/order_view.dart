import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> orders = [
    {
      "image": "https://m.media-amazon.com/images/I/71oywN1H24L._SL1500_.jpg",
      "name": "Doms Modelling Clay 8 Shade, Car Shape, Non-Toxic, 8786",
      "price": "Rs. 110",
      "quantity": "x 1",
      "status": "Processing"
    },
    {
      "image": "https://m.media-amazon.com/images/I/51HFC3usvcL._SL1000_.jpg",
      "name":
          "Transparent Sticky Notes With Free Pentonic Ball Pen (7.5x7.5cm, 50 Sheets)",
      "price": "Rs. 109",
      "quantity": "x 1",
      "status": "Processing"
    },
    {
      "image": "https://m.media-amazon.com/images/I/81k9j-sgMfL._SL1500_.jpg",
      "name": "ProArt Round Stretched Canvas 12'' - Professional Quality",
      "price": "Rs. 385",
      "quantity": "x 1",
      "status": "Processing"
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.orange,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.orange,
          tabs: const [
            Tab(text: "All"),
            Tab(text: "To Pay"),
            Tab(text: "To Ship"),
            Tab(text: "To Receive"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(), // All Orders
          _buildOrderList(), // To Pay
          _buildOrderList(), // To Ship
          _buildOrderList(), // To Receive
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return _buildOrderItem(orders[index]);
      },
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(order["image"],
                width: 60, height: 60, fit: BoxFit.cover),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order["name"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(order["price"],
                      style:
                          const TextStyle(color: Colors.black, fontSize: 14)),
                  Text(order["quantity"],
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              order["status"],
              style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
