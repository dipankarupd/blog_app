import 'package:car_rental/cores/entity/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(Profile? profile) {
    if (profile == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedInState(profile: profile));
    }
  }
}
