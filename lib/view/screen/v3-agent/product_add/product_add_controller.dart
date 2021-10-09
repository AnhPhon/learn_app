import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class V3ProductAddController extends GetxController {
  //image
  File? image;
  List<File> taxImageList = [];

  List<TextEditingController> textControllerList = [];

  List<String> titleList = [
    "Tên sản phẩm",
    "Thương hiệu sản phẩm",
    "Giá sản phẩm",
    "Mã sản phẩm",
    "Quy cách",
    "Chi tiết sản phẩm",
  ];

  String title = "Thêm sản phẩm";

  @override
  void onInit() {
    super.onInit();
    textControllerList =
        List<TextEditingController>.filled(7, TextEditingController());
  }

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
}
