import 'package:bhumi_mobile/common/core/app_theme/app_theme.dart';
import 'package:bhumi_mobile/view/welcome_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      home: const WelcomeView(),
    );
  }
}
