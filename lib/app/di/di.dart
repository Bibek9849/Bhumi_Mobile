import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/core/network/api_service.dart';
import 'package:bhumi_mobile/core/network/hive_service.dart';
import 'package:bhumi_mobile/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:bhumi_mobile/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:bhumi_mobile/features/auth/data/repository/auth_local_repository.dart';
import 'package:bhumi_mobile/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/login_use_case.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/login_bloc.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/signup_bloc.dart';
import 'package:bhumi_mobile/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:bhumi_mobile/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initSplashDependencies();
  await _initOnboardingDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initSplashDependencies() {
  getIt.registerFactory<SplashCubit>(() => SplashCubit());
}

_initOnboardingDependencies() {
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
}

_initRegisterDependencies() {
// =========================== Data Source ===========================

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // =========================== Repository ===========================

  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<RegisterUserUseCase>(
    () => RegisterUserUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<SignupBloc>(
    () => SignupBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      signupBloc: getIt<SignupBloc>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}
