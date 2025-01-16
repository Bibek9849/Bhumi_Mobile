import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0); // Initial state is 0, the first page.

  void goToNextPage() {
    if (state < 2) {
      emit(state + 1); // Emit next page index
    } else {
      emit(3); // Emit value 3 to indicate the last page, trigger navigation
    }
  }

  void skipToLogin() {
    emit(3); // Emit value 3 to skip directly to the login page
  }
}
