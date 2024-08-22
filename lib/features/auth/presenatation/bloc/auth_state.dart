part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

abstract class AuthActionState extends AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadingSuccessState extends AuthState {
  final String userId;

  AuthLoadingSuccessState({required this.userId});
}

class AuthFailedState extends AuthState {
  final String message;

  AuthFailedState({required this.message});
}
