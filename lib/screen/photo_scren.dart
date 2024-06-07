import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/album_list_controller.dart';
import 'package:task1/controller/user_controller.dart';
import 'package:task1/screen/upload_image_screen.dart';

import '../controller/photo_list_controller.dart';

class PhotoScreen extends StatefulWidget {
  final String albumId;
  const PhotoScreen({Key? key, required this.albumId}) : super(key: key);

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final PhotoListController _photoListController =
      Get.put(PhotoListController());

  @override
  void initState() {
    _photoListController.photoListData(widget.albumId);
    print('album id....${widget.albumId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
          actions:  [
            InkWell(
              onTap: (){
                Get.to(UploadImageScreen());
              },

              child: const Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Icon(Icons.photo),
              ),
            )
          ],

      ),
      body: Obx(
        () => (_photoListController.isPhotoLoading.value == false)
            ? _photoListController.isError.value == true
                ? Center(
                    child: Text(
                        _photoListController.errorMessage.value.toString()),
                  )
                : Container(
                    padding: const EdgeInsets.all(16),
                    child: _photoListController.photoList.isEmpty
                        ? const Center(child: Text("Image not Found"))
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // number of items in each row
                              mainAxisSpacing: 8.0, // spacing between rows
                              crossAxisSpacing: 8.0, // spacing between columns
                            ),
                            itemCount: _photoListController.photoList.length,
                            itemBuilder: (context, index) {
                              final photo =
                                  _photoListController.photoList[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(UploadImageScreen());
                                },
                                child: Card(
                                  elevation: 3,
                                  child: Image.network(photo.thumbnailUrl ?? '',
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  }, errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                    return const Center(
                                        child: Icon(Icons.error_outline));
                                  }),
                                ),
                              );
                            },
                          ))
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
