import 'dart:io';

import 'package:flutter/services.dart';
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
    isButtonActive = !isButtonActive;

    update();
    Future.delayed(Duration(seconds: 2), () {
      isButtonActive = true;
      update();
    });
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
