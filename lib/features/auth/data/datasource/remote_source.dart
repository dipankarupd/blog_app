import 'package:car_rental/features/auth/data/model/user_profile_model.dart';

abstract interface class AuthRemoteSource {
  Future<ProfileModel> signupWithEmailAndPassword(
      {required String username,
      required String email,
      required String password});

  Future<String> signinWithEmailAndPassword(
      {required String email, required String password});
}
