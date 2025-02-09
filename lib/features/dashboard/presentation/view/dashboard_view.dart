import 'package:bhumi_mobile/common/product_card.dart';
import 'package:bhumi_mobile/features/dashboard/presentation/view_model/bloc/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  final List<String> categories = ["All", "Vegetables", "Fruits", "Spice"];

  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Row (Image on Left)
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage("assets/images/home.png"), // Profile Image
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Welcome Message
                const Text(
                  "Welcome,\nBibek Pandey",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    onChanged: (query) {
                      context
                          .read<DashboardBloc>()
                          .add(SearchProductEvent(query));
                    },
                    decoration: const InputDecoration(
                      hintText: "Search vegetables..",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Chip(
                          label: Text(category),
                          backgroundColor: category == "All"
                              ? Colors.green
                              : Colors.grey[200],
                          labelStyle: TextStyle(
                            color:
                                category == "All" ? Colors.white : Colors.black,
                          ),
                          // onPressed: () {
                          // context.read<DashboardBloc>().add(SelectCategoryEvent(category));
                          // },
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                // Product Section
                const Text("Our Products",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                    if (state is ProductsLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductsLoadedState) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: state.products.map((product) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: ProductCard(
                                name: product["name"]!,
                                price: product["price"]!,
                                image: product["image"]!, // Show Product Image
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else if (state is ProductsErrorState) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
