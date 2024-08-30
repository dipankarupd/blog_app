import 'package:car_rental/config/app_route.dart';
import 'package:car_rental/cores/utils/calculate_reading_time.dart';
import 'package:car_rental/features/blogs/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class blogDisplayCard extends StatelessWidget {
  final Blog blog;
  final Color color;

  const blogDisplayCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(context, AppRoute.viewBlog, arguments: blog),
      child: SizedBox(
        height: 200,
        child: Card(
          margin: const EdgeInsets.all(16).copyWith(bottom: 6),
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: blog.topics
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5),
                                child: Chip(
                                  label: Text(e),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Text(
                      blog.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
                Text('${calculateReadingTime(blog.content)} min read')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
