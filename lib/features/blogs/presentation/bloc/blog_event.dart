part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

class UploadBlogEvent extends BlogEvent {
  final File image;
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;

  UploadBlogEvent({
    required this.image,
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
  });
}

class FetchBlogsEvent extends BlogEvent {}

class UserSignoutButtonPressedEvent extends BlogEvent {}
