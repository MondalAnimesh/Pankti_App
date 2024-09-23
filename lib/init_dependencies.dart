import 'package:get_it/get_it.dart';
import 'package:pankti_app/core/common/cubits/app_users/app_user_cubit.dart';
import 'package:pankti_app/core/hidden/supabase_keys.dart';
import 'package:pankti_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pankti_app/features/auth/data/soursces/auth_supabase_data_source.dart';
import 'package:pankti_app/features/auth/domain/repo/auth_repo.dart';
import 'package:pankti_app/features/auth/domain/usecases/current_user.dart';
import 'package:pankti_app/features/auth/domain/usecases/user_login.dart';
import 'package:pankti_app/features/auth/domain/usecases/user_signup.dart';
import 'package:pankti_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseKeys.supabaseUrl,
    anonKey: SupabaseKeys.supabaseAnon,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  serviceLocator.registerFactory<AuthSupabaseDataSource>(
    () => AuthSupabaseDataSourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignup(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => CurrentUser(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}
