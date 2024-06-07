import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task1/global/global_message.dart';
import 'dart:convert';

import 'package:task1/model/user_list_model.dart';
import 'package:task1/services/https_services.dart';

class UserController extends GetxController {
  var userList = <UserListModel>[].obs;

  RxBool isError = false.obs;
  RxString errorMessage = "".obs;
  RxBool isLoading = false.obs;

  Future<void> getUserData() async {
    isLoading(true);
    try {
      String url = 'users';
      var response = await HttpServices.httpGetWithoutToken(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}');
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          isError(false);
          errorMessage("");

          var users = jsonData.map((user) => UserListModel.fromJson(user)).toList();

          userList.value = users;
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
      print("user    --  $e");
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  addUser(dynamic mapData) async {
    isLoading(true);
    try {
      String url = 'users';

      var response = await HttpServices.httpPostWithoutToken(url, mapData);
      if (response.statusCode == 200 || response.statusCode == 201) {
          isError(false);
          errorMessage("");
          print('===========');
          print(response.body);
          print('===========');
          Get.snackbar('Success', 'Add User successfully',
              snackPosition: SnackPosition.BOTTOM);
          Get.back();

      }else {
        isError(true);
        errorMessage(GlobalMessages.internalservererror);
      }
    } catch (e) {
      isError(true);
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}



