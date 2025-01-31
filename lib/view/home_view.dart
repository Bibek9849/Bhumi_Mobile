import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryFilters(),
              SizedBox(height: 16),
              ProductSection(title: "Terlaris hari ini", products: [
                ProductItem("Broccoli", "IDR 16.000/kg", "assets/broccoli.png"),
                ProductItem("Tomato", "IDR 8.000/kg", "assets/images/pot.jpg"),
                ProductItem("Green Pepper", "IDR 14.500/kg", "assets/home.png"),
              ]),
              SizedBox(height: 16),
              PromoSection(),
              SizedBox(height: 16),
              ProductSection(title: "Flashsale 🔥", products: [
                ProductItem(
                    "Green Broccoli", "IDR 16.000/kg", "assets/broccoli.png"),
                ProductItem("Red Tomato", "IDR 8.000/kg", "assets/tomato.png"),
                ProductItem("Sawi Hijau", "IDR 14.500/kg", "assets/pepper.png"),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryFilters extends StatelessWidget {
  const CategoryFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FilterChip(label: "All"),
        FilterChip(label: "Vegetables"),
        FilterChip(label: "Fruits"),
        FilterChip(label: "Spice"),
      ],
    );
  }
}

class FilterChip extends StatelessWidget {
  final String label;
  const FilterChip({super.key, required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold)),
    );
  }
}

class ProductSection extends StatelessWidget {
  final String title;
  final List<ProductItem> products;
  const ProductSection(
      {super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: products,
          ),
        ),
      ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const ProductItem(this.name, this.price, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 50),
          const SizedBox(height: 8),
          Text(name,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(price,
              style: const TextStyle(fontSize: 12, color: Colors.green)),
          const SizedBox(height: 4),
          const Icon(Icons.add_circle, color: Colors.green),
        ],
      ),
    );
  }
}

class PromoSection extends StatelessWidget {
  const PromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Discount 50%",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const Text("*Limited",
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          const Text("SPESIAL PENGGUNA BARU",
              style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green, backgroundColor: Colors.white),
            child: const Text("Claim voucher"),
          ),
        ],
      ),
    );
  }
}
