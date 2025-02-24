// import 'package:bhumi_mobile/features/category/domain/entity/category_entity.dart';
// import 'package:bhumi_mobile/features/category/domain/use_case/get_all_category_usecase.dart';
// import 'package:bhumi_mobile/features/dashboard/domain/entity/product_entity.dart';
// import 'package:bhumi_mobile/features/dashboard/domain/use_case/get_all_product_usecase.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';

// part 'dashboard_event.dart';
// part 'dashboard_state.dart';

// class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
//   final GetAllProductUseCase _getAllProductUseCase;
//   final GetAllCategoryUsecase _getAllCategoryUsecase;

//   DashboardBloc({
//     required GetAllProductUseCase getAllProductUseCase,
//     required GetAllCategoryUsecase getAllCategoryUseCase,
//   })  : _getAllProductUseCase = getAllProductUseCase,
//         _getAllCategoryUsecase = getAllCategoryUseCase,
//         super(DashboardState.initial()) {
//     on<LoadProducts>(_onLoadProducts);
//     on<LoadCategories>(_onLoadCategories);

//     // Call this event whenever the bloc is created to load the batches
//     add(LoadProducts());
//     add(LoadCategories());
//   }

//   Future<void> _onLoadProducts(
//       LoadProducts event, Emitter<DashboardState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _getAllProductUseCase.call();

//     result.fold(
//       (failure) {
//         print("API Error: ${failure.message}");
//         emit(state.copyWith(isLoading: false, error: failure.message));
//       },
//       (products) {
//         print("Fetched Products: ${products.length}"); // Debugging
//         for (var product in products) {
//           print("Product Name: ${product.name}, Price: ${product.price}");
//         }
//         emit(state.copyWith(isLoading: false, products: products));
//       },
//     );
//   }

//   Future<void> _onLoadCategories(
//       LoadCategories event, Emitter<DashboardState> emit) async {
//     emit(state.copyWith(isLoading: true));

//     final result = await _getAllCategoryUsecase.call();

//     result.fold(
//       (failure) {
//         emit(state.copyWith(isLoading: false, error: failure.message));
//       },
//       (categories) {
//         emit(state.copyWith(isLoading: false, categories: categories));
//       },
//     );
//   }
// }
