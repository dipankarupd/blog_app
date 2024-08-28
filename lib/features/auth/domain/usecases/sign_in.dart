import 'package:car_rental/cores/usecase/usecase.dart';
import 'package:car_rental/cores/utils/error.dart';
import 'package:car_rental/cores/entity/user_profile.dart';
import 'package:car_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class SignIn implements UseCase<Profile, SignInParams> {
  final AuthRepository authRepository;

  SignIn({required this.authRepository});

  @override
  Future<Either<Failure, Profile>> call(SignInParams params) async {
    return await authRepository.signinWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}
