import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SplashController extends GetxController {
  File? file;
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
    Future.delayed(Duration(seconds: 2),(){
      isButtonActive = true;
      update();
    });
  }

  Future pickImages() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      print(images);
      if (images == null){
        print("Null");
        return;
      };
      file = File(images.path);
      print("File ${file.toString()}");
      update();
    } on PlatformException catch (e) {
     print(e.message);
    }
  }



  
}
