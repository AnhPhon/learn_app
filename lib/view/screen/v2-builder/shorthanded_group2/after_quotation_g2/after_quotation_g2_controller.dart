import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/routes/app_routes.dart';

class V2AfterQuotationG2Controller extends GetxController {
  File? image;
  List<File> imageList = [];

  String title = "Báo giá";

  List<String> quotationInfo = [
    "Khách hàng cung cấp thông tin",
    "Đến hiện trường",
  ];

  ///
  ///pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      imageList.add(imageTemporary);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///on btn edit click
  ///
  void onBtnEditClick() {
    Get.back();
  }

  ///
  ///on btn send click
  ///
  void onBtnSendClick() {
    Get.offNamed(AppRoutes.V2_SHORTHANDED);
  }
}
