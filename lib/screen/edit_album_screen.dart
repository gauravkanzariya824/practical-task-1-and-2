import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/edit_album_controler.dart';
import 'package:task1/controller/edit_user_details_controller.dart';

class EditAlbumScreen extends StatefulWidget {
  final String albumId;
  const EditAlbumScreen({Key? key, required this.albumId}) : super(key: key);
  @override
  State<EditAlbumScreen> createState() => _EditAlbumScreenState();
}

class _EditAlbumScreenState extends State<EditAlbumScreen> {
  final EditAlbumController editAlbumController =
      Get.put(EditAlbumController());

  @override
  void initState() {
    editAlbumController.albumDetails(widget.albumId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Details'),
      ),
      body: Obx(() {
        if (editAlbumController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (editAlbumController.isError.value) {
          return Center(
              child: Text('Error: ${editAlbumController.errorMessage.value}'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: editAlbumController.albumNameController,
                    maxLines: 3,
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: 'Title', border: InputBorder.none),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 50, // Set a custom height
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Edit User'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextField(
                                          maxLines: 3,
                                          controller: editAlbumController
                                              .albumNameController,
                                          decoration: const InputDecoration(
                                              labelText: 'Title'),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                            ),
                                            TextButton(
                                              child: const Text('Edit'),
                                              onPressed: () async {
                                                try {
                                                  var mapData =
                                                      <String, dynamic>{};
                                                  mapData['title'] =
                                                      editAlbumController
                                                          .albumNameController
                                                          .text;

                                                  await editAlbumController
                                                      .updateAlbumDetails(
                                                          mapData,
                                                          context,
                                                          widget.albumId);
                                                  Navigator.of(context).pop();
                                                } catch (e) {
                                                  debugPrint(e.toString());
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 18, // Font size
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Edit'),
                        ),
                      ),
                      /*  SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 50, // Set a custom height
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              var mapData = <String, dynamic>{};
                              mapData['title'] =
                                  editAlbumController.albumNameController.text;

                              editAlbumController.updateAlbumDetails(
                                  mapData, context, widget.albumId);
                            } catch (e) {
                              debugPrint(e.toString());
                            }

                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 18, // Font size
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Edit'),
                        ),
                      ),*/
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await editAlbumController
                                  .deleteAlbum(widget.albumId.toString());
                              Future.delayed(const Duration(milliseconds: 1),
                                  () {
                                Navigator.pop(context);
                              });
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                          ),
                          child: const Text('Delete'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
