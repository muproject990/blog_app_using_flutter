import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();

  // static Route<Object?> route() {}
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.done_rounded,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            image != null
                ? GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    child: DottedBorder(
                        color: AppPallete.borderColor,
                        dashPattern: const [10, 4],
                        radius: const Radius.circular(10),
                        strokeCap: StrokeCap.round,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: const Column(
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                            ],
                          ),
                        )),
                  ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  "Tech",
                  "Entertainment",
                  "Programming",
                  "Business",
                ]
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            if (selectedTopics.contains(e)) {
                              selectedTopics.remove(e);
                            } else {
                              selectedTopics.add(e);
                            }
                            setState(() {
                              print(selectedTopics);
                            });
                          },
                          child: Chip(
                            color: selectedTopics.contains(e)
                                ? const MaterialStatePropertyAll(
                                    AppPallete.gradient1,
                                  )
                                : null,
                            label: Text(e),
                            side: selectedTopics.contains(e)
                                ? null
                                : const BorderSide(
                                    color: AppPallete.borderColor),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlogEditor(
              controller: titleController,
              hintText: "Blog Title",
            ),
            const SizedBox(
              height: 10,
            ),
            BlogEditor(
              controller: contentController,
              hintText: "Blog Content",
            ),
          ],
        ),
      ),
    );
  }
}
