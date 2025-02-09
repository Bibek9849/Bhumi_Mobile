part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class HomeInitialState extends DashboardState {}

class ProductsLoadingState extends DashboardState {}

class ProductsLoadedState extends DashboardState {
  final List<Map<String, String>> products;
  ProductsLoadedState(this.products);
}

class ProductsErrorState extends DashboardState {
  final String message;
  ProductsErrorState(this.message);
}
