// lib/core/app_theme/app_theme.dart
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: Colors.grey[200],
      fontFamily: 'Montserrat Regular',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat Bold',
          ),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.green,
        elevation: 4,
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: Color(0xff00FF00),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black87),
        headlineSmall: TextStyle(color: Colors.black87),
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        elevation: 2,
      ),
      iconTheme: const IconThemeData(color: Colors.black54),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black87),
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: Colors.grey[900],
      fontFamily: 'Montserrat Regular',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat Bold',
          ),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.black,
        elevation: 4,
        titleTextStyle: TextStyle(
          fontSize: 16,
          color: Color(0xff00FF00),
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
      ),
      cardTheme: CardTheme(
        color: Colors.grey[800],
        elevation: 2,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.grey),
      ),
    );
  }
}

// import 'package:bhumi_mobile/app/constants/theme_constant.dart';
// import 'package:flutter/material.dart';

// class AppTheme {
//   AppTheme._();

//   static getApplicationTheme({required bool isDarkMode}) {
//     return ThemeData(
//       // change the theme according to the user preference
//       colorScheme: isDarkMode
//           ? const ColorScheme.dark(
//               primary: ThemeConstant.darkPrimaryColor,
//             )
//           : const ColorScheme.light(
//               primary: Color.fromARGB(255, 17, 119, 20),
//             ),
//       brightness: isDarkMode ? Brightness.dark : Brightness.light,
//       fontFamily: 'Montserrat Regular',
//       useMaterial3: true,

//       // Change app bar color
//       appBarTheme: const AppBarTheme(
//         elevation: 0,
//         backgroundColor: ThemeConstant.appBarColor,
//         centerTitle: true,
//         titleTextStyle: TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//         ),
//       ),

//       // Change elevated button theme
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           elevation: 0,
//           foregroundColor: Colors.white,
//           backgroundColor: ThemeConstant.primaryColor,
//           textStyle: const TextStyle(
//             fontSize: 20,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//       ),

//       // Change text field theme
//       inputDecorationTheme: const InputDecorationTheme(
//         contentPadding: EdgeInsets.all(15),
//         border: OutlineInputBorder(),
//         labelStyle: TextStyle(
//           fontSize: 20,
//         ),
//         errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.red,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: ThemeConstant.primaryColor,
//           ),
//         ),
//       ),
//       // Circular progress bar theme
//       progressIndicatorTheme: const ProgressIndicatorThemeData(
//         color: ThemeConstant.primaryColor,
//       ),
//       //Bottom navigation bar theme
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: Colors.lightGreen,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black,
//         type: BottomNavigationBarType.fixed,
//         elevation: 0,
//       ),
//     );
//   }
// }
