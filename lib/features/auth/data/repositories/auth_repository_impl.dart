import 'package:fpdart/fpdart.dart';
import 'package:pankti_app/core/error/exceptions.dart';
import 'package:pankti_app/core/error/failure.dart';
import 'package:pankti_app/features/auth/data/soursces/auth_supabase_data_source.dart';
import 'package:pankti_app/core/common/entities/user.dart';
import 'package:pankti_app/features/auth/domain/repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthSupabaseDataSource supabaseDataSource;
  const AuthRepositoryImpl(this.supabaseDataSource);

  @override
  Future<Either<Failure, User>> currentuser() async {
    try {
      final user = await supabaseDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('user not logged in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await supabaseDataSource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await supabaseDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
