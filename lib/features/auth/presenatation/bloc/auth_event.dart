part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  AuthSignUpEvent(
      {required this.username, required this.email, required this.password});
}
