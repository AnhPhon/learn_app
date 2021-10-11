import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/routes/app_routes.dart';

class V2QuotationG2Controller extends GetxController {
  File? image;
  List<File> imageList = [];

  //job name
  final jobNameController = TextEditingController();
  //specifications
  final specificationsController = TextEditingController();
  //weight
  final weightController = TextEditingController();
  //unit price
  final unitPriceController = TextEditingController();
  //order value
  final orderValueController = TextEditingController();

  String title = "Báo giá";

  String orderValue = "0";

  bool allowEdit = false;

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
  ///calculator
  ///
  void calculator() {
    if (unitPriceController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        jobNameController.text.isNotEmpty &&
        specificationsController.text.isNotEmpty) {
      orderValue = (int.parse(unitPriceController.text) *
              int.parse(weightController.text))
          .toString();
    }
    update();
  }

  ///
  ///check condition
  ///
  void condition() {
    if (imageList.isNotEmpty &&
        (unitPriceController.text.isEmpty &&
            weightController.text.isEmpty &&
            jobNameController.text.isEmpty &&
            specificationsController.text.isEmpty)) {
      allowEdit = true;
      orderValue = orderValueController.text;
    }
    update();
  }

  ///
  ///go to after quotation g2 page
  ///
  void onAfterQuotationG2PageClick() {
    Get.toNamed(AppRoutes.V2_AFTER_QUOTATION_GROUP2);
  }
}
