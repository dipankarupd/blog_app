import 'package:car_rental/cores/usecase/usecase.dart';
import 'package:car_rental/cores/utils/error.dart';
import 'package:car_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class Signout implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  Signout({required this.authRepository});
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.signoutUser();
  }
}
