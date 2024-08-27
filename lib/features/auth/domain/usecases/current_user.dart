import 'package:car_rental/cores/usecase/usecase.dart';
import 'package:car_rental/cores/utils/error.dart';
import 'package:car_rental/features/auth/domain/entity/user_profile.dart';
import 'package:car_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements UseCase<Profile, NoParams> {
  final AuthRepository authRepository;

  CurrentUser({required this.authRepository});
  @override
  Future<Either<Failure, Profile>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}
