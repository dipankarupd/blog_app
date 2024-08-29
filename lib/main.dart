import 'package:car_rental/config/app_route.dart';
import 'package:car_rental/cores/cubits/app_user/app_user_cubit.dart';
import 'package:car_rental/cores/init_dependancies.dart';
import 'package:car_rental/cores/theme/theme.dart';
import 'package:car_rental/features/auth/presenatation/bloc/auth_bloc.dart';
import 'package:car_rental/features/auth/presenatation/pages/sign_in_page.dart';
import 'package:car_rental/features/auth/presenatation/pages/sign_up_page.dart';
import 'package:car_rental/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:car_rental/features/blogs/presentation/pages/add_new_blog_page.dart';
import 'package:car_rental/features/blogs/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependancies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLoactor<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLoactor<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLoactor<BlogBloc>(),
      ),
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AuthBloc>().add(AuthCheckUserLoginStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog Application',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedInState;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const SignInPage();
        },
      ),
      routes: {
        AppRoute.signup: (context) => const SignUpPage(),
        AppRoute.signin: (context) => const SignInPage(),
        AppRoute.blog: (context) => const BlogPage(),
        AppRoute.uploadBlog: (context) => const AddNewBlogPage(),
      },
    );
  }
}
