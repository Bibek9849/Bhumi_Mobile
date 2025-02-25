import 'package:bhumi_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Enhanced Top App Bar (Navbar)
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: const Text(
          'Bhumi',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Future Search Action
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // Future Notification Action
            },
          ),
          // IconButton(
          //   icon: const Icon(LucideIcons.logOut, color: Colors.white),
          //   onPressed: () {
          //     showMySnackBar(
          //       context: context,
          //       message: 'Logging out...',
          //       color: Colors.red,
          //     );
          //     context.read<HomeCubit>().logout(context);
          //   },
          // ),
        ],
      ),

      // 🔹 Body: Displays selected tab content
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.views.elementAt(state.selectedIndex);
        },
      ),

      // 🔹 Modern Bottom Navigation Bar
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 3,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: GNav(
                gap: 8,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                color: Colors.grey[600],
                activeColor: Colors.white,
                tabBackgroundColor: Colors.green.shade600,
                padding: const EdgeInsets.all(14),
                tabBorderRadius: 20,
                selectedIndex: state.selectedIndex,
                onTabChange: (index) {
                  context.read<HomeCubit>().onTabTapped(index);
                },
                tabs: const [
                  GButton(
                    icon: Icons.dashboard,
                    text: 'Dashboard',
                  ),
                  GButton(
                    icon: Icons.shopping_cart_rounded,
                    text: 'Orders',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
