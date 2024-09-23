import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pankti_app/core/themes/theme_colors.dart';
import 'package:pankti_app/core/common/widgets/loader.dart';
import 'package:pankti_app/core/common/widgets/snack_bar.dart';
import 'package:pankti_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pankti_app/features/auth/presentation/pages/sign_up.dart';
import 'package:pankti_app/core/common/widgets/auth_field.dart';
import 'package:pankti_app/core/common/widgets/custom_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoding) {
            return const Loader();
          }
          return Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (e) => const SignUpPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (e) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                AuthField(
                  hintText: 'Email Address',
                  controller: emailController,
                ),
                const SizedBox(
                  height: 25,
                ),
                AuthField(
                  hintText: 'Password',
                  isPassword: true,
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                            AuthLogin(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            ),
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(400, 50),
                    backgroundColor: ThemeColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                        color: ThemeColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto'),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                // sign up divider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      child: Text(
                        'Sign up with',
                        style: TextStyle(
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.7,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
