import 'package:bhumi_mobile/app/di/di.dart';
import 'package:bhumi_mobile/core/theme/app_theme.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/login_bloc.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/signup_bloc.dart';
import 'package:bhumi_mobile/features/splash/presentation/view/splash_view.dart';
import 'package:bhumi_mobile/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (_) => getIt<SplashCubit>(),
        ),
        // Add other blocs here as needed
        BlocProvider<SignupBloc>(
          create: (_) => getIt<SignupBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bhumi',
        theme: AppTheme.getApplicationTheme(isDarkMode: false),
        home: const SplashView(),
      ),
    );
  }
}
