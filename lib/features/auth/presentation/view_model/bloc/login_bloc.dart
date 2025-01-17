import 'package:bloc/bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        await Future.delayed(const Duration(seconds: 2));

        if (event.contact == "test" && event.password == "password") {
          yield LoginSuccess();
        } else {
          yield LoginFailure(errorMessage: "Invalid credentials");
        }
      } catch (e) {
        yield LoginFailure(errorMessage: "An error occurred");
      }
    }
  }
}
