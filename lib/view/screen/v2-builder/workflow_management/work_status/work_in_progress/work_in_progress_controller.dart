import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V2WorkInProgressController extends GetxController {
  //khai báo isLoading
  bool isLoading = true;

  final rateBuilder = TextEditingController();

  String job = "Thợ ốp lát";
  String title = "Công trình khách hàng 4 sao tại Đà Nẵng";
  String city = "Đà Nẵng";
  String address = "Ngũ Hành Sơn";
  String status = "Còn 35 ngày";
  bool isStatus = true;
  String result = "Chưa nghiệm thu";
  String rate =
      "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
