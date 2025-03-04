import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:bhumi_mobile/features/dashboard/domain/use_case/get_all_product_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAllProductUseCase _getAllProductUseCase;
  final TokenSharedPrefs _tokenSharedPrefs; // ✅ Inject TokenSharedPrefs

  DashboardBloc({
    required GetAllProductUseCase getAllProductUseCase,
    required TokenSharedPrefs tokenSharedPrefs, // ✅ Receive token storage
  })  : _getAllProductUseCase = getAllProductUseCase,
        _tokenSharedPrefs = tokenSharedPrefs,
        super(DashboardState.initial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadToken>(_onLoadToken); // ✅ Handle token loading

    // Load token and products when the bloc initializes
    add(LoadToken());
    add(LoadProducts());
  }

  // 🔹 Fetch token from shared preferences
  Future<void> _onLoadToken(
      LoadToken event, Emitter<DashboardState> emit) async {
    final result = await _tokenSharedPrefs.getToken();

    result.fold(
      (failure) =>
          emit(state.copyWith(token: null)), // Handle token retrieval failure
      (token) {
        if (token.isNotEmpty) {
          print("DashboardBloc - Token Loaded: $token"); // ✅ Debugging
          emit(state.copyWith(token: token)); // ✅ Store token in state
        }
      },
    );
  }

  // 🔹 Fetch products from API
  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<DashboardState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllProductUseCase.call();

    result.fold(
      (failure) {
        print("API Error: ${failure.message}");
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (products) {
        print("Fetched Products: ${products.length}"); // ✅ Debugging
        for (var product in products) {
          print("Product Name: ${product.name}, Price: ${product.price}");
        }
        emit(state.copyWith(isLoading: false, products: products));
      },
    );
  }

  Future<void> getToken(String token) async {
    final saveResult = await _tokenSharedPrefs.saveToken(token);
    saveResult.fold(
      (failure) => emit(state.copyWith(token: null)), // Handle failure
      (_) => emit(state.copyWith(token: token)), // Store token in state
    );
  }
}
