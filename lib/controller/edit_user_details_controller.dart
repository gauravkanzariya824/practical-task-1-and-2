import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task1/screen/user_screen.dart';
import 'package:task1/services/https_services.dart';

class EditUserController extends GetxController {
  var user = {}.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  Future<void> getUserDetails(String userId) async {
    isLoading(true);
    try {
      String url = 'users/$userId';
      var response = await HttpServices.httpGetWithoutToken(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}');
        var data = json.decode(response.body);
        user.value = data;

        nameController.text = user['name'];
        usernameController.text = user['username'];
        emailController.text = user['email'];
        phoneController.text = user['phone'];
        websiteController.text = user['website'];
        companyController.text = user['company']['name'];
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

  Future<void> updateUserDetails(
      queryParameters, context, String userId) async {
    isLoading(true);
    try {
      String url = 'users/$userId';

      var response = await HttpServices.httpPatch(url, queryParameters);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        user.value = data;

        nameController.text = user['name'];
        usernameController.text = user['username'];
        emailController.text = user['email'];
        phoneController.text = user['phone'];
        websiteController.text = user['website'];
        companyController.text = user['company']['name'];

        isError(false);
        Get.snackbar('Success', 'User Details updated successfully',
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


  Future<void> deleteUser(String userId) async {
    isLoading(true);
    try {
      String url = 'users/$userId';

      var response = await HttpServices.httpDelete(url);

      if (response.statusCode == 200) {
        print("my delete response --- ${response.body}");
        isError(false);
        Get.snackbar('Success', 'User Deleted successfully',
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
