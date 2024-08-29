import 'package:car_rental/cores/usecase/usecase.dart';
import 'package:car_rental/cores/utils/error.dart';
import 'package:car_rental/features/blogs/domain/repository/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAllBlogs implements UseCase {
  final BlogRepository blogRepository;

  GetAllBlogs({
    required this.blogRepository,
  });
  @override
  Future<Either<Failure, dynamic>> call(params) async {
    return await blogRepository.getAllBlogs();
  }
}
