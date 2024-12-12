import 'dart:ffi';

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bhumi",
          style: TextStyle(
            color: Color.fromRGBO(55, 95, 22, 1),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: screenHeight * 0.4, // Set width
                height: screenHeight * 0.4, // Set height

                child: const CircleAvatar(
                  backgroundColor: Color.fromRGBO(55, 95, 22, 1),
                  child: Image(
                    image: AssetImage('assets/images/home.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome",
                style: TextStyle(
                  color: Color.fromRGBO(55, 95, 22, 1),
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
