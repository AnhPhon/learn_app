import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V4HomeController extends GetxController {
  List<Map<String, dynamic>>? contentGrid;

  double? total;
  double? revenue; // thu
  double? expenditure; // chi

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    contentGrid = [
      {
        "title": "Mới tạo",
        "quality": 3,
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xff79B4B8),
        ])
      },
      {
        "title": "Đang làm",
        "quality": "2",
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xff00B4D8),
        ]),
      },
      {
        "title": "Hoàn Thành",
        "quality": "4",
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xff00A676),
        ]),
      },
      {
        "title": "Chậm trễ",
        "quality": "1",
        "color": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xffD00000),
        ]),
      }
    ];

    total = 10000000;
    revenue = 10000000;
    expenditure = 10000000;
  }
}
