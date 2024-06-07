import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task1/controller/Image_controller.dart';

class UploadImageScreen extends StatelessWidget {
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Image '),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (imageController.selectedImagePath.value.isEmpty) {
                return const Text('');
              } else {
                return Column(
                  children: [
                    Image.file(
                      File(imageController.selectedImagePath.value),
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                        onPressed: () {
                          imageController.removeImage();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.red,
                        )),
                  ],
                );
              }
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showImagePickerOptions(context);
              },
              child: const Text('Select Image'),
            ),
          ],
        ),
      ),
    );
  }

  void showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                imageController.pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),

            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
