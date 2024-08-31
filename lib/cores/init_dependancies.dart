import 'package:car_rental/cores/cubits/app_user/app_user_cubit.dart';
import 'package:car_rental/cores/network/connection_checker.dart';
import 'package:car_rental/cores/network/connection_checker_impl.dart';
import 'package:car_rental/cores/secrets/supabase_secrets.dart';
import 'package:car_rental/features/auth/data/datasource/remote_source.dart';
import 'package:car_rental/features/auth/data/datasource/remote_source_impl.dart';
import 'package:car_rental/features/auth/data/repository/auth_repo_impl.dart';
import 'package:car_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:car_rental/features/auth/domain/usecases/current_user.dart';
import 'package:car_rental/features/auth/domain/usecases/sign_in.dart';
import 'package:car_rental/features/auth/domain/usecases/sign_up.dart';
import 'package:car_rental/features/auth/domain/usecases/signout.dart';
import 'package:car_rental/features/auth/presenatation/bloc/auth_bloc.dart';
import 'package:car_rental/features/blogs/data/datasource/blog_remote_data_source.dart';
import 'package:car_rental/features/blogs/data/datasource/blog_remote_data_source_impl.dart';
import 'package:car_rental/features/blogs/data/repository/blog_repo_impl.dart';
import 'package:car_rental/features/blogs/domain/repository/blog_repository.dart';
import 'package:car_rental/features/blogs/domain/usecases/get_all_blogs.dart';
import 'package:car_rental/features/blogs/domain/usecases/upload_blog_usecase.dart';
import 'package:car_rental/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLoactor = GetIt.instance;

Future<void> initDependancies() async {
  await dotenv.load(fileName: '.env');

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseApon,
  );
  _initAuth();
  _initBlog();

  // Register Supabase client first
  serviceLoactor.registerLazySingleton(() => supabase.client);
  serviceLoactor.registerFactory(() => InternetConnection());

  serviceLoactor.registerLazySingleton(() => AppUserCubit());
  serviceLoactor.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      internetConnection: serviceLoactor(),
    ),
  );
}

void _initAuth() {
  // create dependancy for AuthRemoteSourceImpl
  // here I need new instance everytime it is being called
  serviceLoactor
    ..registerFactory<AuthRemoteSource>(
      () => AuthRemoteSourceImpl(
        supabaseClient: serviceLoactor(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepoImpl(
        serviceLoactor(),
        source: serviceLoactor(),
      ),
    )
    ..registerFactory<SignUp>(
      () => SignUp(
        authRepository: serviceLoactor(),
      ),
    )
    ..registerFactory<SignIn>(
      () => SignIn(authRepository: serviceLoactor()),
    )
    ..registerFactory<CurrentUser>(
      () => CurrentUser(authRepository: serviceLoactor()),
    )
    ..registerFactory<Signout>(
      () => Signout(authRepository: serviceLoactor()),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        signup: serviceLoactor(),
        signin: serviceLoactor(),
        currentUser: serviceLoactor(),
        appUserCubit: serviceLoactor(),
      ),
    );
}

void _initBlog() {
  serviceLoactor
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(supabaseClient: serviceLoactor()),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(dataSource: serviceLoactor()),
    )
    ..registerFactory(
      () => UploadBlogUsecase(repository: serviceLoactor()),
    )
    ..registerFactory(
      () => GetAllBlogs(
        blogRepository: serviceLoactor(),
      ),
    )
    ..registerLazySingleton(
      () => BlogBloc(
        serviceLoactor(),
        serviceLoactor(),
        serviceLoactor(),
      ),
    );
}
