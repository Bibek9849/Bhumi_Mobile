part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final List<ProductEntity> products;
  final bool isLoading;
  final String? error;

  const DashboardState({
    required this.products,
    required this.isLoading,
    this.error,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      products: [],
      isLoading: false,
    );
  }

  DashboardState copyWith({
    List<ProductEntity>? products,
    bool? isLoading,
    String? error,
  }) {
    return DashboardState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error];
}
