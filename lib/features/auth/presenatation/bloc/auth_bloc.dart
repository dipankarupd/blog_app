import 'dart:async';

import 'package:car_rental/cores/usecase/usecase.dart';
import 'package:car_rental/features/auth/domain/entity/user_profile.dart';
import 'package:car_rental/features/auth/domain/usecases/current_user.dart';
import 'package:car_rental/features/auth/domain/usecases/sign_in.dart';
import 'package:car_rental/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUp _signUp;
  final SignIn _signIn;
  final CurrentUser _currentUser;
  AuthBloc({
    required SignUp signup,
    required SignIn signin,
    required CurrentUser currentUser,
  })  : _signUp = signup,
        _signIn = signin,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(authSignUpEvent);
    on<AuthSignInEvent>(authSignInEvent);
    on<AuthCheckUserLoginStatusEvent>(authCheckUserLoginStatusEvent);
  }

  FutureOr<void> authSignUpEvent(
      AuthSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final resp = await _signUp(
      SignUpParams(
        username: event.username,
        email: event.email,
        password: event.password,
      ),
    );

    resp.fold(
      (l) {
        emit(AuthFailedState(message: l.message));
        emit(AuthLoadingState());
      },
      (r) => emit(
        AuthLoadingSuccessState(profile: r),
      ),
    );
  }

  FutureOr<void> authSignInEvent(
      AuthSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    final resp = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    resp.fold(
      (l) {
        emit(AuthFailedState(message: l.message));
        emit(AuthLoadingState());
      },
      (r) => emit(
        AuthLoadingSuccessState(profile: r),
      ),
    );
  }

  FutureOr<void> authCheckUserLoginStatusEvent(
      AuthCheckUserLoginStatusEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser.call(NoParams());

    res.fold(
      (l) => emit(AuthFailedState(message: l.message)),
      (r) {
        print(r.email);
        emit(AuthLoadingSuccessState(profile: r));
      },
    );
  }
}
