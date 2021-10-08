import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/routes/app_routes.dart';

class V1TaxController extends GetxController {
  File? image;

  final taxController = TextEditingController();

  List<File> taxImageList = [];

  String title = "Hồ sơ thuế của bạn";

  ///
  ///pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      taxImageList.add(imageTemporary);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///on click btn done
  ///
  void onBtnDoneClick() {
    Get.offNamed(AppRoutes.V1_PROFILE);
  }
}
