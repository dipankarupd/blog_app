import 'package:car_rental/cores/utils/error.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {

  Future<Either<Failure, String>> signupWithEmailAndPassword({
    required String username,
    required String email,
    required String password
  });

  Future<Either<Failure, String>> signinWithEmailAndPassword({
    required String email,
    required String password
  });

}