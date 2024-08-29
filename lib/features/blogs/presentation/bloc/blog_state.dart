part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogActionState extends BlogState {}

final class BlogLoadingState extends BlogState {}

final class BlogLoadSuccessState extends BlogActionState {}

final class BlogLoadingFailureState extends BlogActionState {
  final String message;

  BlogLoadingFailureState({required this.message});
}
