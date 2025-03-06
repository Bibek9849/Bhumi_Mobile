import 'package:bhumi_mobile/app/di/di.dart';
import 'package:bhumi_mobile/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:bhumi_mobile/features/dashboard/presentation/view_model/bloc/dashboard_bloc.dart';
import 'package:bhumi_mobile/features/order_details/presentation/view/dashboard_view.dart';
import 'package:bhumi_mobile/features/profile/presentation/view/profile_view.dart';
import 'package:bhumi_mobile/features/profile/presentation/view_model/bloc/student_profile_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final String? token;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
    this.token,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      token: null, // Ensure token is initialized
      views: [
        BlocProvider(
          create: (context) => getIt<DashboardBloc>(),
          child: const DashboardView(),
        ),
        BlocProvider(
          create: (context) => getIt<DashboardBloc>(),
          child: const OrderView(),
        ),
        BlocProvider(
          create: (context) => getIt<StudentProfileBloc>(),
          child: const ProfileView(),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
    String? token, // <-- Added to update token
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
      token: token ?? this.token, // <-- Ensure token is copied
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views, token]; // <-- Added token
}
