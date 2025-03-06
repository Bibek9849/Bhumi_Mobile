import 'package:bhumi_mobile/app/di/di.dart';
import 'package:bhumi_mobile/core/theme/app_theme.dart';
import 'package:bhumi_mobile/core/theme/theme_cubit.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';
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
        BlocProvider(create: (_) => ThemeCubit()), // ✅ Add ThemeCubit here
        BlocProvider<SplashCubit>(create: (_) => getIt<SplashCubit>()),
        BlocProvider<SignupBloc>(create: (_) => getIt<SignupBloc>()),
        BlocProvider<LoginBloc>(create: (_) => getIt<LoginBloc>()),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bhumi',
            theme: AppThemes.getLightTheme(),
            darkTheme: AppThemes.getDarkTheme(),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const SplashView(),
          );
        },
      ),
    );
  }
}
