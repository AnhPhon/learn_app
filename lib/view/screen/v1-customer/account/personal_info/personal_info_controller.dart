import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class V1PersonalInfoController extends GetxController {
  final nameController = TextEditingController();

  String urlImage =
      "https://upload.wikimedia.org/wikipedia/commons/1/1e/Default-avatar.jpg";

  ///
  ///btn back
  ///
  void onBtnBackClick() {
    Get.back();
  }
}
