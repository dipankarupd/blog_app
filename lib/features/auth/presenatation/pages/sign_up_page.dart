import 'package:car_rental/config/app_route.dart';
import 'package:car_rental/cores/common/widgets/loader.dart';
import 'package:car_rental/cores/utils/show_snackbar.dart';
import 'package:car_rental/features/auth/presenatation/bloc/auth_bloc.dart';
import 'package:car_rental/features/auth/presenatation/widgets/auth_button.dart';
import 'package:car_rental/features/auth/presenatation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // perform validation:
    //formKey.currentState!.validate();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<AuthBloc, AuthState>(
          listenWhen: (previous, current) => current is AuthActionState,
          buildWhen: (previous, current) => current is! AuthActionState,
          listener: (context, state) {
            if (state is AuthFailedState) {
              return showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 140,
                    ),
                    const Text(
                      'My Blog App\nWelcome Aboard!!',
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 131, 96, 226)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Sign up to register',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: Column(
                      children: [
                        AuthField(
                          hintText: 'hint: johndoe123',
                          placeholder: 'Enter the Username',
                          controller: usernameController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthField(
                          hintText: 'hint: johndoe@gmail.com',
                          placeholder: 'Enter the Email',
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthField(
                          placeholder: 'Enter the Password',
                          isObscure: true,
                          controller: passwordController,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AuthGradinetButton(
                          buttonText: 'Sign Up',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthSignUpEvent(
                                      username: usernameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context).pushNamed(AppRoute.signin),
                          child: RichText(
                            text: TextSpan(
                                text: 'Already have an account? ',
                                style: Theme.of(context).textTheme.titleMedium,
                                children: const [
                                  TextSpan(
                                      text: 'Sign In',
                                      style: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontWeight: FontWeight.bold))
                                ]),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
