import 'package:car_rental/cores/utils/calculate_reading_time.dart';
import 'package:car_rental/cores/utils/format_date.dart';
import 'package:car_rental/features/blogs/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewPage extends StatelessWidget {
  const BlogViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blog = ModalRoute.of(context)?.settings.arguments as Blog;
    print(blog.imageUrl);
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'By ${blog.posterName}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${formatDate(blog.updatedAt)} \t ${calculateReadingTime(blog.content)} min',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(blog.imageUrl),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  blog.content,
                  style: const TextStyle(height: 2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
