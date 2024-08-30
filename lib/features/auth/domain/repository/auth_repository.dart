import 'package:car_rental/cores/utils/error.dart';
import 'package:car_rental/cores/entity/user_profile.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, Profile>> signupWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failure, Profile>> signinWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, Profile>> currentUser();

  Future<Either<Failure, Unit>> signoutUser();
}
