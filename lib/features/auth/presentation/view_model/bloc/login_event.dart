abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String contact;
  final String password;

  LoginButtonPressed({required this.contact, required this.password});
}
