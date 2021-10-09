import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V3OrderManagementController extends GetxController {
  Map<String, String> statusPayment = {
    "1": "Chưa thanh toán",
    "2": "Đã thanh toán",
  };
  Map<String, String> statusLabel = {
    "1": "Mới tạo",
    "2": "Đang xử lý",
    "3": "Đã vận chuyển",
    "4": "Đã giao hàng",
    "5": "Hủy đơn",
  };
  Map<String, Color> statusColor = {
    "1": const Color(0xff007D3A),
    "2": const Color(0xff0D5BB5),
    "3": const Color(0xffCC8100),
    "4": const Color(0xffBF1D28),
    "5": const Color(0xffA6A6B0),
  };

  Map<String, Color> statusBackgroundColor = {
    "1": const Color(0x1f007D3A),
    "2": const Color(0x1f0D5BB5),
    "3": const Color(0x1fCC8100),
    "4": const Color(0x1fBF1D28),
    "5": const Color(0x1fA6A6B0),
  };

  String urlImage =
      "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  List<OderManagement> orderList = [
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "1",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "2",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "3",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "4",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
    OderManagement(
      id: Random().nextInt(1000).toString(),
      statusOrder: "5",
      image:
          "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
      dateTime: DateTime.now().toString(),
    ),
  ];

  String title = "Quản lý đơn hàng";
}

class OderManagement {
  String id;
  String statusOrder;
  String image;
  String dateTime;
  OderManagement(
      {required this.id,
      required this.statusOrder,
      required this.image,
      required this.dateTime});
}
