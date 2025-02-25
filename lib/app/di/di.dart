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
import 'package:bhumi_mobile/features/category/data/data_source/remote_datasource/category_remote_data_source.dart';
import 'package:bhumi_mobile/features/dashboard/data/data_source/remote_datasource/product_remote_datasource.dart';
import 'package:bhumi_mobile/features/dashboard/data/repository/product_remote_repository.dart';
import 'package:bhumi_mobile/features/dashboard/domain/use_case/get_all_product_usecase.dart';
import 'package:bhumi_mobile/features/dashboard/presentation/view_model/bloc/dashboard_bloc.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:bhumi_mobile/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:bhumi_mobile/features/profile/presentation/view_model/bloc/profile_bloc.dart';
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
  await _initHomeDependencies();
  await _initDashboardDependencies();
  await _initProfileDependencies();
  await _initCategoryDependencies();
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
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      signupBloc: getIt<SignupBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(getIt<TokenSharedPrefs>()),
  );
}

_initDashboardDependencies() async {
  // =========================== Data Source ===========================

  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );
  // =========================== Repository ===========================
  getIt.registerLazySingleton(
    () => ProductRemoteRepository(
      remoteDataSource: getIt<ProductRemoteDataSource>(),
    ),
  );
  // =========================== Usecases ===========================

  getIt.registerLazySingleton<GetAllProductUseCase>(
    () => GetAllProductUseCase(
        productRepository: getIt<ProductRemoteRepository>()),
  );
  // =========================== Bloc ===========================

  getIt.registerFactory<DashboardBloc>(
    () => DashboardBloc(
      getAllProductUseCase: getIt<GetAllProductUseCase>(),
      tokenSharedPrefs: getIt<TokenSharedPrefs>(),
    ),
  );
}

_initProfileDependencies() async {
  getIt.registerFactory<ProfileBloc>(
    () => ProfileBloc(),
  );
}

_initCategoryDependencies() async {
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );
}
