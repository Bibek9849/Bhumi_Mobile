import 'package:bhumi_mobile/app/di/di.dart';
import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/features/auth/presentation/view/login_view.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/bloc/login_bloc.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final TokenSharedPrefs _tokenSharedPrefs;

  HomeCubit(this._tokenSharedPrefs) : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  Future<void> logout(BuildContext context) async {
    // Clear the token
    await _tokenSharedPrefs
        .saveToken(""); // Save an empty string to remove token

    // Navigate back to LoginView after a delay
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: const LoginView(),
            ),
          ),
        );
      }
    });
  }

  Future<void> setToken(String token) async {
    final saveResult = await _tokenSharedPrefs.saveToken(token);
    saveResult.fold(
      (failure) => emit(state.copyWith(token: null)), // Handle failure
      (_) => emit(state.copyWith(token: token)), // Store token in state
    );
  }
}
