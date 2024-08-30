import 'package:car_rental/config/app_route.dart';
import 'package:car_rental/cores/common/widgets/loader.dart';
import 'package:car_rental/cores/utils/show_snackbar.dart';
import 'package:car_rental/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:car_rental/features/blogs/presentation/widgets/blog_display_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(FetchBlogsEvent());
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogLoadingFailureState) {
            return showSnackbar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoadingState) {
            return const Loader();
          }
          if (state is BlogListState) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return blogDisplayCard(
                  blog: blog,
                  color: Colors.deepPurpleAccent,
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
