import 'package:bhumi_mobile/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
