import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V4HomeController extends GetxController {
  List<Map<String, dynamic>> contentGrid = [
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

  double total = 10000000;
  double revenue = 10000000; // thu
  double expenditure = 10000000; // chi
}
