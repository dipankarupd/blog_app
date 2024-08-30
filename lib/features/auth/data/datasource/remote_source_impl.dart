import 'package:car_rental/cores/exceptions/custom_exception.dart';
import 'package:car_rental/features/auth/data/datasource/remote_source.dart';
import 'package:car_rental/features/auth/data/model/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final SupabaseClient supabaseClient;

  AuthRemoteSourceImpl({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<ProfileModel> signupWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
          password: password, email: email, data: {'username': username});

      if (response.user == null) {
        throw ServerException(message: 'User is null');
      }
      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProfileModel> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw ServerException(message: 'User is null');
      }
      return ProfileModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ProfileModel?> getCurrentUser() async {
    try {
      print(currentUserSession);
      if (currentUserSession != null) {
        // user data is the list of maps but the list contain only one element
        // as on filtering only one element is present
        final userData = await supabaseClient
            .from('profiles')
            .select('*')
            .eq('id', currentUserSession!.user.id);

        // as userdata list has only one element, we are returning that
        // userdata ==> [{...}]
        return ProfileModel.fromJson(userData.first)
            .copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> signout() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
