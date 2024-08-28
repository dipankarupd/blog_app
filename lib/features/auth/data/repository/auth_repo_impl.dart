import 'package:car_rental/cores/exceptions/custom_exception.dart';
import 'package:car_rental/cores/utils/error.dart';
import 'package:car_rental/features/auth/data/datasource/remote_source.dart';
import 'package:car_rental/cores/entity/user_profile.dart';
import 'package:car_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteSource source;

  AuthRepoImpl({required this.source});
  @override
  Future<Either<Failure, Profile>> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userProfile = await source.signinWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(userProfile);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Profile>> currentUser() async {
    try {
      final user = await source.getCurrentUser();

      // if we get a null user, show a failure with message
      // user is not logged in
      if (user == null) {
        return left(
          Failure(message: 'User not logged in'),
        );
      }

      return right(user);
    } on ServerException catch (e) {
      return left(
        Failure(message: e.message),
      );
    }
  }

  @override
  Future<Either<Failure, Profile>> signupWithEmailAndPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final userProfile = await source.signupWithEmailAndPassword(
        username: username,
        email: email,
        password: password,
      );

      // this is giving either failure or userId(success)
      // when successful give the userId so use right() method
      return right(userProfile);
    } on ServerException catch (e) {
      // when failure occur, return the failure part using left()

      return left(Failure(message: e.message));
    }
  }
}
