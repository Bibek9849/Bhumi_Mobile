import 'package:bhumi_mobile/view/dashboard_view.dart';
import 'package:bhumi_mobile/view/home_view.dart';
import 'package:bhumi_mobile/view/login_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
