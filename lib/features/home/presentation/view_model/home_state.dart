import 'package:bhumi_mobile/app/di/di.dart';
import 'package:bhumi_mobile/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:bhumi_mobile/features/dashboard/presentation/view_model/bloc/dashboard_bloc.dart';
import 'package:bhumi_mobile/features/profile/presentation/view/profile_view.dart';
import 'package:bhumi_mobile/features/profile/presentation/view_model/bloc/profile_bloc.dart';
import 'package:bhumi_mobile/view/order_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<DashboardBloc>(),
          child: DashboardView(),
        ),
        BlocProvider(
          create: (context) => getIt<DashboardBloc>(),
          child: const OrderView(),
        ),
        BlocProvider(
            create: (context) => getIt<ProfileBloc>(),
            child: const ProfileView()),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
