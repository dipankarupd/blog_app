import 'dart:io';

import 'package:car_rental/features/blogs/data/models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadblog(BlogModel blog);
  Future<String> uploadBlogImage(File image, BlogModel blog);
}
