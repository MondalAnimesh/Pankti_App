import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pankti_app/core/common/cubits/app_users/app_user_cubit.dart';
import 'package:pankti_app/core/themes/theme.dart';
import 'package:pankti_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pankti_app/features/auth/presentation/pages/login_page.dart';
import 'package:pankti_app/features/pankti/presentation/pages/home_page.dart';
import 'package:pankti_app/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: BlocProvider(
        create: (context) => AppUserCubit(),
        child: BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) {
            return state is AppUserLoggedIn;
          },
          builder: (context, isLoggedIn) {
            if (isLoggedIn) {
              return const Scaffold(
                body: Center(
                  child: Text('heli'),
                ),
              );
            }
            return const HomePage();
          },
        ),
      ),
    );
  }
}
