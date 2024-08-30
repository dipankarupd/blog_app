import 'package:car_rental/cores/cubits/app_user/app_user_cubit.dart';
import 'package:car_rental/cores/secrets/supabase_secrets.dart';
import 'package:car_rental/features/auth/data/datasource/remote_source.dart';
import 'package:car_rental/features/auth/data/datasource/remote_source_impl.dart';
import 'package:car_rental/features/auth/data/repository/auth_repo_impl.dart';
import 'package:car_rental/features/auth/domain/repository/auth_repository.dart';
import 'package:car_rental/features/auth/domain/usecases/current_user.dart';
import 'package:car_rental/features/auth/domain/usecases/sign_in.dart';
import 'package:car_rental/features/auth/domain/usecases/sign_up.dart';
import 'package:car_rental/features/auth/presenatation/bloc/auth_bloc.dart';
import 'package:car_rental/features/blogs/data/datasource/blog_remote_data_source.dart';
import 'package:car_rental/features/blogs/data/datasource/blog_remote_data_source_impl.dart';
import 'package:car_rental/features/blogs/data/repository/blog_repo_impl.dart';
import 'package:car_rental/features/blogs/domain/repository/blog_repository.dart';
import 'package:car_rental/features/blogs/domain/usecases/get_all_blogs.dart';
import 'package:car_rental/features/blogs/domain/usecases/upload_blog_usecase.dart';
import 'package:car_rental/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLoactor = GetIt.instance;

Future<void> initDependancies() async {
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabase_url,
    anonKey: AppSecrets.supabase_apon,
  );

  // Register Supabase client first
  serviceLoactor.registerLazySingleton(() => supabase.client);

  // Initialize other dependencies
  _initAuth();
  _initBlog();
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
    ..registerLazySingleton(
      () => AppUserCubit(),
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
      ),
    );
}
