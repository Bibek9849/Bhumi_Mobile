import 'package:bhumi_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:bhumi_mobile/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initRegisterDependencies() async {
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(),
  );
}

_initLoginDependencies() async {
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}
