import 'package:car_rental/config/app_route.dart';
import 'package:car_rental/features/auth/presenatation/widgets/auth_button.dart';
import 'package:car_rental/features/auth/presenatation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // perform validation:
    //formKey.currentState!.validate();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
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
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
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
                      onPressed: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed(AppRoute.initial),
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
        ),
      ),
    );
  }
}
