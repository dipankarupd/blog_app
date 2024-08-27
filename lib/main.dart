import 'package:car_rental/config/app_route.dart';
import 'package:car_rental/cores/init_dependancies.dart';
import 'package:car_rental/cores/theme/theme.dart';
import 'package:car_rental/features/auth/presenatation/bloc/auth_bloc.dart';
import 'package:car_rental/features/auth/presenatation/pages/sign_in_page.dart';
import 'package:car_rental/features/auth/presenatation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependancies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLoactor<AuthBloc>(),
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
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AuthBloc>().add(AuthCheckUserLoginStatusEvent());
  }

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
