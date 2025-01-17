import 'package:bhumi_mobile/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:bhumi_mobile/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initSplashScreenDependencies();
  await _initOnboardingScreenDependencies();
}

Future<void> _initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(),
  );
}

Future<void> _initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(),
  );
}
