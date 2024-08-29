import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:car_rental/features/blogs/domain/usecases/upload_blog_usecase.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUsecase _uploadBlogUsecase;
  BlogBloc(
    this._uploadBlogUsecase,
  ) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoadingState());
    });

    on<UploadBlogEvent>(uploadBlogEvent);
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
}
