import 'package:bhumi_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:bhumi_mobile/core/common/snackbar/my_snackbar.dart';
import 'package:bhumi_mobile/features/auth/domain/use_case/login_use_case.dart';
import 'package:bhumi_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';
import 'package:bhumi_mobile/features/home/presentation/view/home_view.dart';
import 'package:bhumi_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignupBloc _signupBloc;
  final HomeCubit _homeCubit;
  final LoginUseCase _loginUseCase;
  final TokenSharedPrefs _tokenSharedPrefs;

  LoginBloc({
    required SignupBloc signupBloc,
    required HomeCubit homeCubit,
    required LoginUseCase loginUseCase,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _signupBloc = signupBloc,
        _homeCubit = homeCubit,
        _loginUseCase = loginUseCase,
        _tokenSharedPrefs = tokenSharedPrefs,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _signupBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<NavigateHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _homeCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<LoginUserEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));

        final result = await _loginUseCase(
          LoginParams(
            contact: event.contact,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
          (token) async {
            emit(state.copyWith(isLoading: false, isSuccess: true));

            // Save Token
            await _tokenSharedPrefs.saveToken(token);

            // Decode Token to Extract User ID
            Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
            String? userId = decodedToken['id'];

            if (userId != null) {
              await _tokenSharedPrefs.saveUserId(userId);
            }

            // Retrieve and Print Token and User ID
            final storedToken = await _tokenSharedPrefs.getToken();
            final storedUserId = await _tokenSharedPrefs.getUserId();

            print("====== LOGIN SUCCESS ======");
            print("Token: ${storedToken.getOrElse(() => 'No Token Saved')}");
            print(
                "User ID: ${storedUserId.getOrElse(() => 'No User ID Saved')}");
            print("===========================");

            showMySnackBar(
              context: event.context,
              message: "Login Successful",
              color: Colors.green,
            );

            add(NavigateHomeScreenEvent(
              context: event.context,
              destination: const HomeView(),
            ));
          },
        );
      },
    );
  }
}
