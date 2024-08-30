import 'dart:async';

import 'package:car_rental/cores/cubits/app_user/app_user_cubit.dart';
import 'package:car_rental/cores/usecase/usecase.dart';
import 'package:car_rental/cores/entity/user_profile.dart';
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
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required SignUp signup,
    required SignIn signin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _signUp = signup,
        _signIn = signin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    // for all auth event, emit an auth loading state
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
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
        // emit(AuthLoadingState());
      },
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  FutureOr<void> authSignInEvent(
      AuthSignInEvent event, Emitter<AuthState> emit) async {
    final resp = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    resp.fold(
      (l) {
        emit(AuthFailedState(message: l.message));
      },
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  FutureOr<void> authCheckUserLoginStatusEvent(
      AuthCheckUserLoginStatusEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser.call(NoParams());

    res.fold((l) {
      emit(AuthFailedState(message: l.message));
      emit(AuthInitial());
    }, (r) => _emitAuthSuccess(r, emit));
  }

  // this updates the user information using the cubit
  void _emitAuthSuccess(Profile profile, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(profile);
    emit(AuthSuccessState(profile: profile));
  }
}
