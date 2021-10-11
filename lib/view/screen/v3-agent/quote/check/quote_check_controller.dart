import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';

class V3QuoteCheckController extends GetxController {
  String tieuDeBaoGia = "Cần báo giá xi măng";
  String dateTime = "12-09-2021";
  double cost = 50000;

  List<Map<String, dynamic>>? infoCard;
  List<Map<String, dynamic>>? features;

  bool isCheck = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    infoCard = [
      {
        "label": "Tên vật liệu",
        "value": "Xi măng",
        "input": false,
      },
      {
        "label": "Quy cách",
        "value": "Kim đỉnh",
        "input": false,
      },
      {
        "label": "Số lượng",
        "value": "5",
        "input": false,
      },
      {
        "label": "Đơn vị",
        "value": "Tấn",
        "input": false,
      },
      {
        "label": "Đơn giá",
        "value": "300.000 VND",
        "input": false,
      },
    ];

    features = [
      {"title": "Chỉnh sửa", "onTap": () {}, "color": const Color(0XFFB0BAC1)},
      {
        "title": "Xác nhận báo giá",
        "onTap": () {
          Get.back();
          Get.back();
          Get.back();
        },
        "color": ColorResources.THEME_DEFAULT
      },
    ];
  }
}
