import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:convert';

import 'package:task1/services/https_services.dart';

class EditAlbumController extends GetxController {
  var album = {}.obs;
  var user = {}.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  TextEditingController albumNameController = TextEditingController();


  Future<void> albumDetails(String userId) async {
    isLoading(true);
    try {
      String url = 'albums/$userId';
      var response = await HttpServices.httpGetWithoutToken(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}');
        var data = json.decode(response.body);
        album.value = data;

        albumNameController.text = album['title'];



      } else {
        isError(true);
        errorMessage("Internal server error");
      }
    } catch (e) {
      isError(true);
      print("editAlbum    --  $e");
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateAlbumDetails(
      queryParameters, context, String userId) async {
    isLoading(true);
    try {
      String url = 'albums/$userId';

      var response = await HttpServices.httpPatch(url, queryParameters);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        album.value = data;

        albumNameController.text = album['title'];


        isError(false);
        Get.snackbar('Success', 'Album Details updated successfully',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error !!', 'Something went to wrong',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isError(true);
      print("----------$e");
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }


  Future<void> deleteAlbum(String userId) async {
    isLoading(true);
    try {
      String url = 'albums/$userId';

      var response = await HttpServices.httpDelete(url);

      if (response.statusCode == 200) {
        print("my delete response --- ${response.body}");
        isError(false);
        Get.snackbar('Success', 'Album Deleted successfully',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        isError(true);
        errorMessage('Failed to delete user data');
      }
    } catch (e) {
      isError(true);
      print("----------$e");
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

}
