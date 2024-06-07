import 'package:get/get.dart';
import 'package:task1/model/album_list_model.dart';
import 'dart:convert';
import 'package:task1/services/https_services.dart';

class AlbumListController extends GetxController {
  var albumList = <AlbumListModel>[].obs;

  RxBool isError = false.obs;
  RxString errorMessage = "".obs;
  RxBool isAlubumLoading = false.obs;

  Future<void> albumListData(String userId) async {
    isAlubumLoading(true);
    try {
      String url = 'albums?userId=$userId';
      var response = await HttpServices.httpGetWithoutToken(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Album Response body: ${response.body}');
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          isError(false);
          errorMessage("");

          var users = jsonData.map((user) => AlbumListModel.fromJson(user)).toList();

          albumList.value = users;
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
      isAlubumLoading(false);
    }
  }
}
