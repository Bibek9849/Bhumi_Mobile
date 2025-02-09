import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is EditProfileEvent) {
      yield ProfileLoading();
      try {
        // Simulate the edit profile operation
        await Future.delayed(const Duration(seconds: 1));
        yield const ProfileLoaded(
            username: "Bibek Pandey", profileImage: "path/to/image");
      } catch (e) {
        yield const ProfileError("Failed to edit profile");
      }
    } else if (event is LogoutEvent) {
      yield ProfileLoading();
      try {
        // Simulate logout
        await Future.delayed(const Duration(seconds: 1));
        yield ProfileInitial(); // Reset state to initial after logout
      } catch (e) {
        yield const ProfileError("Failed to log out");
      }
    }
  }
}
