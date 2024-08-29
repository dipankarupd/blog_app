import 'dart:io';

import 'package:car_rental/cores/exceptions/custom_exception.dart';
import 'package:car_rental/cores/utils/error.dart';
import 'package:car_rental/features/blogs/data/datasource/blog_remote_data_source.dart';
import 'package:car_rental/features/blogs/data/models/blog_model.dart';
import 'package:car_rental/features/blogs/domain/entities/blog.dart';
import 'package:car_rental/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource dataSource;

  BlogRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> topics,
    required String posterId,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final uploadedImage = await dataSource.uploadBlogImage(image, blogModel);

      blogModel = blogModel.copyWith(
        imageUrl: uploadedImage,
      );

      final uploadedData = await dataSource.uploadblog(blogModel);

      return right(uploadedData);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
