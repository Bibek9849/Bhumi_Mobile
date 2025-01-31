import 'package:bhumi_mobile/view/cart_view.dart';
import 'package:bhumi_mobile/view/home_view.dart';
import 'package:bhumi_mobile/view/product_view.dart';
import 'package:bhumi_mobile/view/profile_view.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  final List<Widget> _bottomScreens = [
    const HomeScreen(),
    const ProductView(),
    const CartView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 197, 201, 194),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Bhumi',
              style: TextStyle(
                fontFamily: 'Montserrat Bold',
                fontSize: 30,
                color: Color.fromARGB(255, 132, 46, 46),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 132, 46, 46),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: _bottomScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 255, 235, 202),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
