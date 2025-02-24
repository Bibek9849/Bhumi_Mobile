import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
import 'package:bhumi_mobile/features/dashboard/domain/use_case/get_all_product_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAllProductUseCase _getAllProductUseCase;

  DashboardBloc({
    required GetAllProductUseCase getAllProductUseCase,
  })  : _getAllProductUseCase = getAllProductUseCase,
        super(DashboardState.initial()) {
    on<LoadProducts>(_onLoadProducts);

    // Call this event whenever the bloc is created to load the batches
    add(LoadProducts());
  }

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
        print("Fetched Products: ${products.length}"); // Debugging
        for (var product in products) {
          print("Product Name: ${product.name}, Price: ${product.price}");
        }
        emit(state.copyWith(isLoading: false, products: products));
      },
    );
  }
}
