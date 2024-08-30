part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

class BlogActionState extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogLoadSuccessState extends BlogActionState {}

final class BlogLoadingFailureState extends BlogActionState {
  final String message;

  BlogLoadingFailureState({required this.message});
}

class BlogListState extends BlogState {
  final List<Blog> blogs;

  BlogListState({required this.blogs});
}

class BlogSignoutSuccessState extends BlogActionState {}

class BlogSignoutFailureState extends BlogActionState {
  final String message;

  BlogSignoutFailureState({required this.message});
}
