part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final List<ProductEntity> products;
  final bool isLoading;
  final String? error;
  final String? token; // ✅ Ensure token is part of the state

  const DashboardState({
    required this.products,
    required this.isLoading,
    this.token,
    this.error,
  });

  factory DashboardState.initial() {
    return const DashboardState(
      products: [],
      isLoading: false,
      token: null, // ✅ Initialize token as null
    );
  }

  DashboardState copyWith({
    List<ProductEntity>? products,
    bool? isLoading,
    String? error,
    String? token, // ✅ Allow token to be updated
  }) {
    return DashboardState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      token: token ?? this.token, // ✅ Ensure token is copied
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error, token]; // ✅ Add token
}
