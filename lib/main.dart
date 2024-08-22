import 'package:car_rental/config/app_route.dart';
import 'package:car_rental/cores/secrets/supabase_secrets.dart';
import 'package:car_rental/cores/theme/theme.dart';
import 'package:car_rental/features/auth/data/datasource/remote_source_impl.dart';
import 'package:car_rental/features/auth/data/repository/auth_repo_impl.dart';
import 'package:car_rental/features/auth/domain/usecases/sign_up.dart';
import 'package:car_rental/features/auth/presenatation/bloc/auth_bloc.dart';
import 'package:car_rental/features/auth/presenatation/pages/sign_in_page.dart';
import 'package:car_rental/features/auth/presenatation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = await Supabase.initialize(
      url: AppSecrets.supabase_url, anonKey: AppSecrets.supabase_apon);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBloc(
          signup: SignUp(
            authRepository: AuthRepoImpl(
              source: AuthRemoteSourceImpl(supabaseClient: supabase.client),
            ),
          ),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blog Application',
        theme: AppTheme.darkThemeMode,
        //home: SignUpPage(),
        initialRoute: AppRoute.initial,
        routes: {
          AppRoute.initial: (context) => const SignInPage(),
          AppRoute.signup: (context) => SignUpPage()
        });
  }
}
