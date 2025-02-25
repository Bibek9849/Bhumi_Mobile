import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:bhumi_mobile/features/dashboard/presentation/view_model/bloc/dashboard_bloc.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_state.dart';
import 'package:bhumi_mobile/features/product_details/presentation/view/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with profile & cart icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return const Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/images/profile.png"),
                            ),
                            SizedBox(width: 10), // Add spacing
                            Text(
                              "Hi, ${"Bibek Pandey"}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.purple.shade100,
                      child:
                          const Icon(Icons.shopping_bag, color: Colors.purple),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Categories Section
                _buildSectionHeader("Categories"),
                const SizedBox(height: 10),
                _buildCategoriesList(),
                const SizedBox(height: 20),

                // Top Selling Products Section
                _buildSectionHeader("Top Selling"),
                const SizedBox(height: 10),
                _buildProductSection(),

                const SizedBox(height: 20),

                // New Arrivals Section
                _buildSectionHeader("New In", isPurple: true),
                const SizedBox(height: 10),
                _buildProductSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool isPurple = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isPurple ? Colors.purple : Colors.black,
          ),
        ),
        const Text("See All", style: TextStyle(color: Colors.purple)),
      ],
    );
  }

  Widget _buildCategoriesList() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.error != null) {
          return Center(child: Text(state.error!));
        } else if (state.products.isEmpty) {
          return const Center(child: Text("No categories available"));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: state.products.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      category.product_categoryId.categoryName,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildProductSection() {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.error != null) {
          return Center(child: Text(state.error!));
        } else if (state.products.isEmpty) {
          return const Center(child: Text("No products available"));
        }
        return _buildProductList(context, state.products);
      },
    );
  }

  Widget _buildProductList(BuildContext context, List<ProductEntity> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
          print("Product Image URL: ${product.image}"); // ✅ Debugging output

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: product),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'http://192.168.1.68:3000/product_type_images/${product.image}', // ✅ Corrected string interpolation
                        // 'http://10.0.2.2:3000/product_type_images/${product.image}',
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png', // ✅ Local fallback image
                            height: 120,
                            fit: BoxFit.cover, // Ensure consistent sizing
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // Prevents overflow
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Rs ${product.price}/ K.G",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
