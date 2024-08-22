import 'package:car_rental/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signUp;
  AuthBloc({required SignUp signup})
      : _signUp = signup,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(event, emit) async {
      final resp = await _signUp(SignUpParams(
          username: event.username,
          email: event.email,
          password: event.password));

      resp.fold(
          (l) => emit(AuthFailedState(message: l.message)),
          (r) => emit(AuthLoadingSuccessState(
                userId: r,
              )));
    }
  }
}
