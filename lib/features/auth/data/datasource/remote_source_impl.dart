import 'package:car_rental/cores/exceptions/custom_exception.dart';
import 'package:car_rental/features/auth/data/datasource/remote_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final SupabaseClient supabaseClient;

  AuthRemoteSourceImpl({required this.supabaseClient});

  @override
  Future<String> signupWithEmailAndPassword({
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
      return response.user!.id;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> signinWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement signinWithEmailAndPassword
    throw UnimplementedError();
  }
}
