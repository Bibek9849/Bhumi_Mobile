part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends SignupEvent {}

class RegisterUser extends SignupEvent {
  final BuildContext context;
  final String fullName;
  final String contact;
  final String address;
  final String password;

  const RegisterUser({
    required this.context,
    required this.fullName,
    required this.contact,
    required this.address,
    required this.password,
  });
}
