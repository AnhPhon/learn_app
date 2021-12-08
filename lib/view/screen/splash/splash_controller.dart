import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SplashController extends GetxController {
  File? fileImage;

  @override
  void onInit() {
    super.onInit();
  }

  bool isButtonActive = true;
  @override
  void onClose() {
    super.onClose();
  }

  void checkButton() {
    print("phone");
    isButtonActive = false;
    update();
  }

  void getImage() async {
    final pickFile = await ImagePicker().pickImage(source: ImageSource.camera);
    fileImage = File(pickFile!.path);
    print(fileImage);
    update();
  }

  void getVideo() async {
    final pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    fileImage = File(pickFile!.path);
    print(fileImage);
    update();
  }
}
