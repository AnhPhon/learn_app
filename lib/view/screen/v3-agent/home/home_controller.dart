import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3HomeController extends GetxController {
  String fullname = "Nguyễn Văn A";
  List<Map<String, dynamic>>? threeFeatures;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    threeFeatures = [
      {
        "icon": Icons.shop,
        "label": "Cửa hàng \ncủa bạn",
        "image": null,
        "gradient": const RadialGradient(colors: [
          Color(0xff8CE3E9),
          Color(0xff8CE3E9),
        ]),
        "onTap": () => Get.toNamed(AppRoutes.V3_STORE),
      },
      {
        "icon": Icons.chat,
        "label": "Phản hồi \nbáo giá",
        "image": null,
        "gradient": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xffC1E6EE),
        ]),
        "onTap": () {}
      },
      {
        "icon": Icons.request_page,
        "label": "Yêu cầu \nbáo giá",
        "image": null,
        "gradient": const RadialGradient(colors: [
          Color(0xff79B4B8),
          Color(0xff79B4B8),
        ]),
        "onTap": () {}
      },
    ];
  }
}
