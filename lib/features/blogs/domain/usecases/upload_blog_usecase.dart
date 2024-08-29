import 'dart:io';

import 'package:car_rental/cores/usecase/usecase.dart';
import 'package:car_rental/cores/utils/error.dart';
import 'package:car_rental/features/blogs/domain/entities/blog.dart';
import 'package:car_rental/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUsecase implements UseCase<Blog, UploadParams> {
  final BlogRepository repository;

  UploadBlogUsecase({required this.repository});
  @override
  Future<Either<Failure, Blog>> call(UploadParams params) async {
    return await repository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
      posterId: params.posterId,
    );
  }
}

class UploadParams {
  final File image;
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;

  UploadParams({
    required this.image,
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
  });
}
