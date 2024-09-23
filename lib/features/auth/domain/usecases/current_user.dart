import 'package:fpdart/fpdart.dart';
import 'package:pankti_app/core/error/failure.dart';
import 'package:pankti_app/core/usecases/usecase.dart';
import 'package:pankti_app/core/common/entities/user.dart';
import 'package:pankti_app/features/auth/domain/repo/auth_repo.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentuser();
  }
}
