import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:bhumi_mobile/features/dashboard/presentation/view_model/bloc/dashboard_bloc.dart';
import 'package:bhumi_mobile/features/product_details/presentation/view/product_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late TokenSharedPrefs tokenSharedPrefs;
  String fullName = "Loading...";
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadUserFullName();
  }

  Future<void> _loadUserFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokenSharedPrefs = TokenSharedPrefs(prefs);

    final result = await tokenSharedPrefs.getUserFullName();
    result.fold(
      (failure) {
        print("❌ Error fetching fullName: ${failure.message}");
      },
      (name) {
        setState(() {
          fullName = name.isNotEmpty ? name : "User not found";
        });
      },
    );
  }

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
                // ✅ Header with full name
                Text(
                  "Hi, $fullName",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Search Bar
                TextField(
                  onChanged: (query) {
                    setState(() {
                      searchQuery = query.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by name (e.g., Wheat, Banana)',
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

                // Vouchers Section
                _buildSectionHeader("Vouchers & Offers", isPurple: true,
                    onTap: () {
                  print("Vouchers clicked");
                }),
                const SizedBox(height: 10),
                _buildVoucherList(),
                const SizedBox(height: 20),

                // Top Selling Products Section
                _buildSectionHeader("Top Selling", onTap: () {
                  print("See All Top Selling");
                }),
                const SizedBox(height: 10),
                _buildProductSection(),
                const SizedBox(height: 20),

                // New Arrivals Section
                _buildSectionHeader("New In", isPurple: true, onTap: () {
                  print("See All New In");
                }),
                const SizedBox(height: 10),
                _buildProductSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title,
      {bool isPurple = false, required VoidCallback onTap}) {
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
        GestureDetector(
          onTap: onTap,
          child: const Text("See All", style: TextStyle(color: Colors.purple)),
        ),
      ],
    );
  }

  Widget _buildVoucherList() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Get 20% off on your first order!",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ),
          SizedBox(height: 5),
          Text(
            "Use code: WELCOME20",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
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
        final filteredProducts = state.products
            .where(
                (product) => product.name.toLowerCase().contains(searchQuery))
            .toList();
        return _buildProductList(context, filteredProducts);
      },
    );
  }

  Widget _buildProductList(BuildContext context, List<ProductEntity> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(
                    product: product,
                    tokenSharedPrefs: tokenSharedPrefs,
                  ),
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
                        'http://10.0.2.2:3000/product_type_images/${product.image}',
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/placeholder.png',
                            height: 120,
                            fit: BoxFit.cover,
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
                      overflow: TextOverflow.ellipsis,
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
