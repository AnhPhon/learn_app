import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedController extends GetxController {
  List<Map<String, dynamic>> shorthandedGroupList = [
    {
      "group": "1",
      "status": "Đang tuyển",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "6",
      "status": "Khảo sát báo giá",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "2",
      "status": "Khảo sát báo giá",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "5",
      "status": "Đang tuyển",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "2",
      "status": "Khảo sát báo giá",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
    {
      "group": "6",
      "status": "Khảo sát báo giá",
      "label": "Biệt thự 170 Nguyễn Đình Thi",
      "image":
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      "icon": const Icon(Icons.location_on),
      "location": "Ngũ Hành Sơn",
    },
  ];

  ///
  ///go to shorthanded group
  ///
  void onShorthandedGroup(int index) {
    Get.toNamed(
        "${AppRoutes.V2_SHORTHANDED}_group${shorthandedGroupList[index]['group']}");
  }
}
