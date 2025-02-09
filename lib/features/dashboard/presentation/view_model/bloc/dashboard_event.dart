part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class LoadProductsEvent extends DashboardEvent {}

class SearchProductEvent extends DashboardEvent {
  final String query;
  SearchProductEvent(this.query);
}

class SelectCategoryEvent extends DashboardEvent {
  final String category;
  SelectCategoryEvent(this.category);
}
