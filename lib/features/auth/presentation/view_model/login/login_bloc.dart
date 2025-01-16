import 'package:bhumi_mobile/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final RegisterBloc _registerBloc;
  final HomeCubit _homeCubit;
  LoginBloc({
    required RegisterBloc registerBloc,
    required HomeCubit homeCubit,
  })  : _registerBloc = registerBloc,
        _homeCubit = homeCubit,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: _registerBloc, child: event.destination),
        ),
      );
    });

    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _homeCubit,
            child: event.destination,
          ),
        ),
      );
    });
  }
}
