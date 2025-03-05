// import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
// import 'package:bhumi_mobile/features/auth/domain/use_case/login_use_case.dart';
// import 'package:bhumi_mobile/features/auth/presentation/view/register_view.dart';
// import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/login_bloc.dart';
// import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/signup_bloc.dart';
// import 'package:bhumi_mobile/features/home/presentation/view_model/home_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:local_auth/local_auth.dart'; // Import local_auth package
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   final _formKey = GlobalKey<FormState>();
//   final _contactController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool isPasswordVisible = false;
//   final LocalAuthentication auth = LocalAuthentication();

//   // Function to handle biometric authentication
//   Future<void> _authenticateBiometric() async {
//     bool authenticated = false;
//     try {
//       authenticated = await auth.authenticate(
//         localizedReason: 'Please authenticate to login',
//         options: const AuthenticationOptions(
//           biometricOnly: true,
//           stickyAuth: true,
//         ),
//       );
//     } catch (e) {
//       debugPrint("Biometric auth error: $e");
//     }
//     if (authenticated) {
//       // If authentication is successful, navigate to home or dispatch a login event.
//       // For example:
//       Navigator.pushReplacementNamed(context, '/home');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Biometric authentication failed")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // For tablets, we often want a narrower column, say max 600 or 700 px.
//     const double maxContentWidth = 600;

//     return FutureBuilder<SharedPreferences>(
//       future: SharedPreferences.getInstance(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final tokenSharedPrefs = TokenSharedPrefs(snapshot.data!);

//         return BlocProvider(
//           create: (context) => LoginBloc(
//             signupBloc: context.read<SignupBloc>(),
//             homeCubit: context.read<HomeCubit>(),
//             loginUseCase: context.read<LoginUseCase>(),
//             tokenSharedPrefs: tokenSharedPrefs,
//           ),
//           child: Scaffold(
//             backgroundColor: const Color(0xFFEAF4EA),
//             body: SafeArea(
//               child: Center(
//                 // Constrain the maximum width of the content
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(
//                     maxWidth: maxContentWidth,
//                   ),
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Illustration
//                           SizedBox(
//                             height: 200,
//                             child: Image.asset(
//                               'assets/images/home.png',
//                               fit: BoxFit.contain,
//                             ),
//                           ),
//                           const SizedBox(height: 20),

//                           // Login Text
//                           const Text(
//                             'Login',
//                             style: TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.green,
//                             ),
//                           ),
//                           const SizedBox(height: 20),

//                           // Contact Input
//                           TextFormField(
//                             controller: _contactController,
//                             decoration: InputDecoration(
//                               labelText: 'Contact',
//                               prefixIcon: const Icon(Icons.phone),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your contact';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 15),

//                           // Password Input
//                           TextFormField(
//                             controller: _passwordController,
//                             obscureText: !isPasswordVisible,
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               prefixIcon: const Icon(Icons.lock),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   isPasswordVisible
//                                       ? Icons.visibility
//                                       : Icons.visibility_off,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     isPasswordVisible = !isPasswordVisible;
//                                   });
//                                 },
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your password';
//                               }
//                               if (value.length < 6) {
//                                 return 'Password must be at least 6 characters';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 10),

//                           // Forgot Password
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: () {
//                                 // Handle Forgot Password
//                               },
//                               child: const Text(
//                                 'Forgot Password?',
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),

//                           // Login Button
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 if (_formKey.currentState?.validate() ??
//                                     false) {
//                                   context.read<LoginBloc>().add(
//                                         LoginUserEvent(
//                                           context: context,
//                                           contact: _contactController.text,
//                                           password: _passwordController.text,
//                                         ),
//                                       );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                               ),
//                               child: const Text(
//                                 'Login',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),

//                           // Google Sign-In Button
//                           SizedBox(
//                             width: double.infinity,
//                             child: OutlinedButton.icon(
//                               onPressed: () {
//                                 // Handle Google Sign-In
//                               },
//                               icon: const Icon(
//                                 Icons.g_mobiledata,
//                                 color: Colors.red,
//                                 size: 30,
//                               ),
//                               label: const Text(
//                                 'Login with Google',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               style: OutlinedButton.styleFrom(
//                                 side: const BorderSide(color: Colors.grey),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),

//                           // Fingerprint Login Button (Biometric Authentication)
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton.icon(
//                               onPressed: _authenticateBiometric,
//                               icon: const Icon(Icons.fingerprint),
//                               label: const Text(
//                                 'Login with Fingerprint',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),

//                           // Register Link
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const Text("New to Logistics? "),
//                               GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           const RegisterView(),
//                                     ),
//                                   );
//                                 },
//                                 child: const Text(
//                                   "Register",
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
