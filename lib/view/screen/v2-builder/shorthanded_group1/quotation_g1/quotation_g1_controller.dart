import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/routes/app_routes.dart';

class V2QuotationG1Controller extends GetxController {
  File? image;
  List<File> imageList = [];

  final unitPriceController = TextEditingController();

  String weight = "20";

  String orderValue = "0";

  String title = "Báo giá";

  @override
  void onInit() {
    super.onInit();
    unitPriceController.addListener(() => calculator());
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
      imageList.add(imageTemporary);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///calculator
  ///
  void calculator() {
    if (unitPriceController.text.isNotEmpty) {
      orderValue =
          (int.parse(unitPriceController.text) * int.parse(weight)).toString();
    }
    update();
  }

  ///
  ///on done click
  ///
  void onDoneClick() {
    Get.offNamed(AppRoutes.V2_SHORTHANDED);
  }
}
