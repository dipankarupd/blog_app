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
              context.read<BlogBloc>().add(UserSignoutButtonPressedEvent());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogLoadingFailureState) {
            return showSnackbar(context, state.message);
          }
          if (state is BlogSignoutFailureState) {
            return showSnackbar(context, state.message);
          } else if (state is BlogSignoutSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoute.signin,
              (Route<dynamic> route) => false,
            );
            return showSnackbar(context, 'Successfully signed out');
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.uploadBlog);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
