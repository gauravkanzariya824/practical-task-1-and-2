import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  var selectedImagePath = ''.obs;

  void pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      Get.snackbar('Error', 'No image selected', snackPosition: SnackPosition.BOTTOM);
    }
  }

  void removeImage() {
    selectedImagePath.value = '';
  }
}
