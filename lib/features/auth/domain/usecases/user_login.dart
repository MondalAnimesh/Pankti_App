import 'package:fpdart/fpdart.dart';
import 'package:pankti_app/core/error/failure.dart';
import 'package:pankti_app/core/usecases/usecase.dart';
import 'package:pankti_app/core/common/entities/user.dart';
import 'package:pankti_app/features/auth/domain/repo/auth_repo.dart';


class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;
  UserLoginParams({
    required this.email,
    required this.password,
  });
}
