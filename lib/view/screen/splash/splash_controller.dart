import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/routes/route_path/demo_base_card_routers.dart';
import 'package:template/routes/route_path/my_order_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void goToMyOrder() {
    Get.toNamed(MyOrderRouter.MY_ORDER);
  }

  void goToDemoBaseCard() {
    Get.toNamed(DemoBaseCardRouter.DEMO_BASE_CARD);
  }
}
