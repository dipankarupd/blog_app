import 'dart:io';

import 'package:car_rental/cores/exceptions/custom_exception.dart';
import 'package:car_rental/features/blogs/data/models/blog_model.dart';
import 'package:car_rental/features/blogs/data/datasource/blog_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({
    required this.supabaseClient,
  });
  @override
  Future<BlogModel> uploadblog(BlogModel blog) async {
    try {
      final uploadedBlog = await supabaseClient
          .from('blogs')
          .insert(blog.toJSON())
          .select()
          .single();

      return BlogModel.fromJSON(uploadedBlog);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(File image, BlogModel blog) async {
    try {
      // upload method takes 2 params -> path and image file
      // path is the path in the supabase storage where I want to put
      // so I will upload the image always in a new place and name it blog.id for each post

      final path = 'uploads/${blog.id}';
      await supabaseClient.storage.from('blog_images').upload(path, image);
      final url = supabaseClient.storage.from('blog_images').getPublicUrl(path);
      return url;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      // get all the blogs:
      final blogs =
          await supabaseClient.from('blogs').select('*, profiles (username)');

      return blogs
          .map(
            (blog) => BlogModel.fromJSON(blog).copyWith(
              posterName: blog['profiles']['username'],
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
