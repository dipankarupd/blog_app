import 'dart:io';

import 'package:car_rental/config/app_route.dart';
import 'package:car_rental/cores/common/widgets/loader.dart';
import 'package:car_rental/cores/cubits/app_user/app_user_cubit.dart';
import 'package:car_rental/cores/palette/app_colors.dart';
import 'package:car_rental/cores/utils/pick_image.dart';
import 'package:car_rental/cores/utils/show_snackbar.dart';
import 'package:car_rental/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:car_rental/features/blogs/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final List<String> selectedItems = [];
  File? image;
  final formKey = GlobalKey<FormState>();

  void addImage() async {
    final pickedImage = await (pickImage());

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogLoadingFailureState) {
          showSnackbar(context, state.message);
        } else if (state is BlogLoadSuccessState) {
          showSnackbar(context, 'Successfully uploaded blog');
          Navigator.pushReplacementNamed(context, AppRoute.blog);
        }
      },
      builder: (context, state) {
        if (state is BlogLoadingState) {
          return Loader();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create a new blog'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      image != null &&
                      selectedItems.isNotEmpty) {
                    // get the poster id:
                    final posterId = (context.read<AppUserCubit>().state
                            as AppUserLoggedInState)
                        .profile
                        .id;

                    context.read<BlogBloc>().add(
                          UploadBlogEvent(
                            image: image!,
                            posterId: posterId,
                            title: titleController.text.trim(),
                            content: contentController.text.trim(),
                            topics: selectedItems,
                          ),
                        );
                  }
                },
                icon: const Icon(Icons.done),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: addImage,
                            child: SizedBox(
                              width: double.infinity,
                              height: 180,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => addImage(),
                            child: DottedBorder(
                              color: Colors.grey,
                              radius: const Radius.circular(12),
                              child: SizedBox(
                                width: double.infinity,
                                height: 170,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                    ),
                                    const Text(
                                      'Select image',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          'Technology',
                          'Business',
                          'Programming',
                          'Entertainment',
                        ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    selectedItems.contains(e)
                                        ? selectedItems.remove(e)
                                        : selectedItems.add(e);
                                    setState(() {});
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    color: selectedItems.contains(e)
                                        ? WidgetStatePropertyAll(
                                            (Colors.deepPurple))
                                        : null,
                                    side: const BorderSide(
                                      color: AppPallete.borderColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlogEditor(
                      controller: titleController,
                      hintText: 'Blog Title',
                      label: 'Enter the blog title',
                    ),
                    const SizedBox(height: 10),
                    BlogEditor(
                      controller: contentController,
                      hintText: 'Blog Contents',
                      label: 'Enter the blog Contents',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
