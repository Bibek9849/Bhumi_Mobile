import 'package:bhumi_mobile/app/di/di.dart';
import 'package:bhumi_mobile/core/theme/app_theme.dart';
import 'package:bhumi_mobile/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:bhumi_mobile/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Management',
      theme: AppTheme.getApplicationTheme(isDarkMode: false),
      home: BlocProvider.value(
        value: getIt<OnboardingCubit>(),
        child: const OnboardingView(),
      ),
    );
  }
}
