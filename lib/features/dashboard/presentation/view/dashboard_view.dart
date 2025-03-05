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
    // You can adjust this max width as needed
    const double maxContentWidth = 600;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          // Constrain the width so the UI doesn’t stretch too wide on tablets
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Greeting
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile.jpg"),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Hi, $fullName",
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
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
                      prefixIcon:
                          Icon(Icons.search, color: colorScheme.primary),
                      filled: true,
                      fillColor: colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Vouchers Section
                  _buildSectionHeader(
                    "Vouchers & Offers",
                    isPurple: true,
                    onTap: () => print("Vouchers clicked"),
                  ),
                  const SizedBox(height: 10),
                  _buildVoucherList(colorScheme, textTheme),
                  const SizedBox(height: 20),

                  // Top Selling Products Section
                  _buildSectionHeader(
                    "Top Selling",
                    onTap: () => print("See All Top Selling"),
                  ),
                  const SizedBox(height: 10),
                  _buildProductSection(colorScheme, textTheme),
                  const SizedBox(height: 20),

                  // New Arrivals Section
                  _buildSectionHeader(
                    "New In",
                    isPurple: true,
                    onTap: () => print("See All New In"),
                  ),
                  const SizedBox(height: 10),
                  _buildProductSection(colorScheme, textTheme),
                ],
              ),
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
            color: isPurple
                ? Colors.purple
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "See All",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }

  Widget _buildVoucherList(ColorScheme colorScheme, TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.purple.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Get 20% off on your first order!",
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Use code: WELCOME20",
            style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection(ColorScheme colorScheme, TextTheme textTheme) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.error != null) {
          return Center(
            child: Text(state.error!, style: textTheme.bodyMedium),
          );
        } else if (state.products.isEmpty) {
          return Center(
            child: Text("No products available", style: textTheme.bodyMedium),
          );
        }

        final filteredProducts = state.products
            .where(
                (product) => product.name.toLowerCase().contains(searchQuery))
            .toList();

        return _buildProductList(
            context, filteredProducts, colorScheme, textTheme);
      },
    );
  }

  Widget _buildProductList(
    BuildContext context,
    List<ProductEntity> products,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
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
                    // Product Image
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
                    // Product Name
                    Text(
                      product.name,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    // Product Price
                    Text(
                      "Rs ${product.price}/ K.G",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
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
