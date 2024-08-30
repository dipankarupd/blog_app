import 'package:car_rental/features/auth/data/model/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteSource {
  // to check whether the user is logged in or not
  Session? get currentUserSession;
  Future<ProfileModel> signupWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<ProfileModel> signinWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<ProfileModel?> getCurrentUser();

  Future<void> signout();
}
