import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:car_rental/cores/usecase/usecase.dart';
import 'package:car_rental/features/auth/domain/usecases/signout.dart';
import 'package:car_rental/features/blogs/domain/entities/blog.dart';
import 'package:car_rental/features/blogs/domain/usecases/get_all_blogs.dart';
import 'package:car_rental/features/blogs/domain/usecases/upload_blog_usecase.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogs _getAllBlogs;
  final Signout _signout;
  BlogBloc(
    this._uploadBlogUsecase,
    this._getAllBlogs,
    this._signout,
  ) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoadingState());
    });

    on<UploadBlogEvent>(uploadBlogEvent);

    on<FetchBlogsEvent>(fetchBlogsEvent);

    on<UserSignoutButtonPressedEvent>(userSignoutButtonPressedEvent);
  }

  FutureOr<void> uploadBlogEvent(
      UploadBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlogUsecase(
      UploadParams(
        image: event.image,
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        topics: event.topics,
      ),
    );
    res.fold(
      (onLeft) => emit(BlogLoadingFailureState(message: onLeft.message)),
      (onRight) {
        print('emitting success state');
        emit(BlogLoadSuccessState());
      },
    );
  }

  FutureOr<void> fetchBlogsEvent(
      FetchBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (l) => emit(BlogLoadingFailureState(message: l.message)),
      (r) => emit(BlogListState(blogs: r)),
    );
  }

  FutureOr<void> userSignoutButtonPressedEvent(
      UserSignoutButtonPressedEvent event, Emitter<BlogState> emit) async {
    final res = await _signout(NoParams());

    res.fold(
      (l) => emit(BlogSignoutFailureState(message: l.message)),
      (r) => emit(BlogSignoutSuccessState()),
    );
  }
}
