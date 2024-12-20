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
    const HomeView(),
    const ProductView(),
    const CartView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(55, 95, 22, 1),
        title: const Text(
          'Bhumi',
          style: TextStyle(
            fontFamily: 'Montserrat Bold',
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _bottomScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: const Color.fromRGBO(55, 95, 22, 1),
        selectedItemColor: const Color.fromRGBO(55, 95, 22, 1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
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
