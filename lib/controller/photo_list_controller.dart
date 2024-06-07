import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task1/model/album_list_model.dart';
import 'package:task1/model/image_list_model.dart';
import 'dart:convert';

import 'package:task1/model/user_list_model.dart';
import 'package:task1/services/https_services.dart';

class PhotoListController extends GetxController {
  var photoList = <PhotoListModel>[].obs;

  RxBool isError = false.obs;
  RxString errorMessage = "".obs;
  RxBool isPhotoLoading = false.obs;

  Future<void> photoListData(String albumId) async {
    isPhotoLoading(true);
    try {
      String url = 'photos?albumId=$albumId';
      var response = await HttpServices.httpGetWithoutToken(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Album Response body: ${response.body}');
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          isError(false);
          errorMessage("");

          var users =
              jsonData.map((user) => PhotoListModel.fromJson(user)).toList();

          photoList.value = users;
        } else {
          isError(true);
          errorMessage("Unexpected JSON format");
        }
      } else {
        isError(true);
        errorMessage("Internal server error");
      }
    } catch (e) {
      isError(true);
      print("Album    --  $e");
      errorMessage(e.toString());
    } finally {
      isPhotoLoading(false);
    }
  }
}
