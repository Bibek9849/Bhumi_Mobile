part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

final class LoadProducts extends DashboardEvent {}

final class AddProduct extends DashboardEvent {}

final class DeleteProduct extends DashboardEvent {}
