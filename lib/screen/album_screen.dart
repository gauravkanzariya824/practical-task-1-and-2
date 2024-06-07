import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controller/album_list_controller.dart';
import 'package:task1/controller/user_controller.dart';
import 'package:task1/screen/edit_album_screen.dart';
import 'package:task1/screen/photo_scren.dart';

class AlubumScreen extends StatefulWidget {
  final String userId;
  const AlubumScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<AlubumScreen> createState() => _AlubumScreenState();
}

class _AlubumScreenState extends State<AlubumScreen> {
  final AlbumListController _albumListController =
      Get.put(AlbumListController());

  @override
  void initState() {
    _albumListController.albumListData(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: Obx(
        () => (_albumListController.isAlubumLoading.value == false)
            ? _albumListController.isError.value == true
                ? Center(
                    child: Text(
                        _albumListController.errorMessage.value.toString()),
                  )
                : Container(
                    padding: const EdgeInsets.all(16),
                    child: _albumListController.albumList.isEmpty
                        ? const Center(child: Text("albums not Found"))
                        : ListView.builder(
                            itemCount: _albumListController.albumList.length,
                            itemBuilder: (context, index) {
                              final album =
                                  _albumListController.albumList[index];
                              return Card(
                                elevation: 3,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(album.title ?? ''),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Get.to(EditAlbumScreen(
                                                    albumId:
                                                        album.id.toString(),
                                                  ));
                                                },
                                                child: const Icon(Icons.edit)),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  Get.to(PhotoScreen(
                                                    albumId:
                                                        album.id.toString(),
                                                  ));
                                                },
                                                child: const Icon(Icons.photo)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
