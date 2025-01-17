// import 'package:bhumi_mobile/common/my_snackbar.dart';
// import 'package:bhumi_mobile/view/dashboard_view.dart';
// import 'package:bhumi_mobile/view/register_view.dart';
// import 'package:flutter/material.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController contactController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool isPasswordVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 50),
//               Image.asset(
//                 'assets/images/logo.png',
//                 height: 100,
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: contactController,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(
//                           labelText: 'Contact Number',
//                           prefixIcon: const Icon(Icons.phone),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your contact number';
//                           }
//                           if (!RegExp(r'^\d{10}$').hasMatch(value)) {
//                             return 'Enter a valid 10-digit phone number';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         controller: passwordController,
//                         obscureText: !isPasswordVisible,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           prefixIcon: const Icon(Icons.lock),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               isPasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 isPasswordVisible = !isPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           if (value.length < 6) {
//                             return 'Password must be at least 6 characters long';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 10),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: TextButton(
//                           onPressed: () {},
//                           child: const Text(
//                             'Forgot password?',
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 child: GestureDetector(
//                   onTap: () {
//                     if (formKey.currentState?.validate() ?? false) {
//                       final contact = contactController.text;
//                       final password = passwordController.text;
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const DashboardView()),
//                       );

//                       showMySnackBar(
//                         context: context,
//                         message: 'Successfully Logged In!',
//                       );
//                     }
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Colors.green, Colors.teal],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight,
//                       ),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     alignment: Alignment.center,
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 child: OutlinedButton.icon(
//                   onPressed: () {
//                     showMySnackBar(
//                       context: context,
//                       message: 'Google Sign-In not implemented yet!',
//                     );
//                   },
//                   icon: const Icon(
//                     Icons.g_mobiledata,
//                     color: Colors.red,
//                     size: 30,
//                   ),
//                   label: const Text(
//                     'Sign in with Google',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                     ),
//                   ),
//                   style: OutlinedButton.styleFrom(
//                     side: const BorderSide(color: Colors.grey),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Don’t have an account? "),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const RegisterView()),
//                       );
//                     },
//                     child: const Text(
//                       "Register here",
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
