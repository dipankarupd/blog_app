import 'package:car_rental/config/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Home'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.uploadBlog);
            },
            icon: const Icon(CupertinoIcons.add_circled),
          )
        ],
      ),
    );
  }
}
