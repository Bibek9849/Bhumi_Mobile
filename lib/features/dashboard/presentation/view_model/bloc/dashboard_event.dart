part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

// ✅ Event to Load Token from Storage
final class LoadToken extends DashboardEvent {}

// ✅ Event to Load Products
final class LoadProducts extends DashboardEvent {}

// ✅ Event to Add a Product
final class AddProduct extends DashboardEvent {}

// ✅ Event to Delete a Product
final class DeleteProduct extends DashboardEvent {}
