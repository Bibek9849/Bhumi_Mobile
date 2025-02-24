import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> orders = [
    {
      "image": "assets/images/profile.png",
      "name": "Doms Modelling Clay 8 Shade, Car Shape, Non-Toxic, 8786",
      "price": 110,
      "quantity": 1,
      "status": "Completed",
      "orderId": "#BH12345",
      "date": "2024-02-20"
    },
    {
      "image": "https://m.media-amazon.com/images/I/51HFC3usvcL._SL1000_.jpg",
      "name":
          "Transparent Sticky Notes With Free Pentonic Ball Pen (7.5x7.5cm, 50 Sheets)",
      "price": 109,
      "quantity": 2,
      "status": "To Ship",
      "orderId": "#BH67890",
      "date": "2024-02-18"
    },
    {
      "image": "https://m.media-amazon.com/images/I/81k9j-sgMfL._SL1500_.jpg",
      "name": "ProArt Round Stretched Canvas 12'' - Professional Quality",
      "price": 385,
      "quantity": 1,
      "status": "To Receive",
      "orderId": "#BH45678",
      "date": "2024-02-15"
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
        title: const Text("My Orders"),
        backgroundColor: const Color.fromARGB(255, 234, 237, 234),
        elevation: 5,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 4, // Make indicator thicker
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
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
          _buildOrderList("All"),
          _buildOrderList("To Pay"),
          _buildOrderList("To Ship"),
          _buildOrderList("To Receive"),
        ],
      ),
    );
  }

  Widget _buildOrderList(String filterStatus) {
    List<Map<String, dynamic>> filteredOrders = filterStatus == "All"
        ? orders
        : orders.where((order) => order["status"] == filterStatus).toList();

    if (filteredOrders.isEmpty) {
      return const Center(
        child: Text(
          "No Orders Found",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        return _buildOrderItem(filteredOrders[index], index);
      },
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order, int index) {
    return GestureDetector(
      onTap: () {
        _showOrderDetails(order);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2, // Soft shadow for premium look
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: order["image"],
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.image_not_supported,
                  size: 70,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 12),
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
                    Text(
                      "Rs. ${order["price"]}  |  Qty: ${order["quantity"]}",
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      order["orderId"],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      "Ordered on: ${order["date"]}",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order["status"]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      order["status"],
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.1),
                    ),
                    onPressed: () => _deleteOrder(index),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteOrder(int index) {
    setState(() {
      orders.removeAt(index);
    });
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Order Details - ${order["orderId"]}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: order["image"],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(order["name"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("Price: Rs. ${order["price"]}"),
              Text("Quantity: ${order["quantity"]}"),
              Text("Status: ${order["status"]}"),
              Text("Order Date: ${order["date"]}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "To Pay":
        return Colors.red;
      case "To Ship":
        return Colors.orange;
      case "To Receive":
        return Colors.blue;
      case "Completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
