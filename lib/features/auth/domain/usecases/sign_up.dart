import 'package:car_rental/cores/usecase/usecase.dart';
import 'package:car_rental/cores/utils/error.dart';
import 'package:car_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

// what is the success type? and what are the parameters?
class SignUp implements UseCase<String, SignUpParams> {
  final AuthRepository authRepository;

  SignUp({required this.authRepository});
  @override
  Future<Either<Failure, String>> call(SignUpParams params) async {
    return await authRepository.signupWithEmailAndPassword(
      username: params.username,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String username;
  final String email;
  final String password;

  SignUpParams({
    required this.username,
    required this.email,
    required this.password,
  });
}
