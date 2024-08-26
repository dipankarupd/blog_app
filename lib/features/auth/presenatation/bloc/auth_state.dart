part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

abstract class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

// build a circular indicator for loading
class AuthLoadingState extends AuthState {}

class AuthLoadingSuccessState extends AuthState {
  final Profile profile;

  AuthLoadingSuccessState({required this.profile});
}

// show snackbar message
class AuthFailedState extends AuthActionState {
  final String message;

  AuthFailedState({required this.message});
}
