import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V2RegisterDoneController extends GetxController {
  // Tiêu đề
  final titleController = TextEditingController();
  // địa chỉ
  final addressController = TextEditingController();

  String title = "Hoàn tất đăng ký";

  ///
  ///go to home
  ///
  void onCompleteClick() {
    Get.back(result: true);
  }
}
