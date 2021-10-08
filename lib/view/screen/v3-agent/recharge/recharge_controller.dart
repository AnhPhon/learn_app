import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/routes/app_routes.dart';

class V3RechargeController extends GetxController {
  File? image;

  String title = "Thông tin thanh toán";

  ///
  ///pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///on checkout click
  ///
  void onCheckoutClick() {
    Get.toNamed(AppRoutes.V3_PAYMENT_SUCCESS);
  }
}
