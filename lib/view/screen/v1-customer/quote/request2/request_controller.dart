import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class V1Request2Controller extends GetxController {
  String title = "Yêu cầu báo giá vật liệu";

  TextEditingController? tieuDeBaoGiaController;

  @override
  void onInit() {
    super.onInit();
    tieuDeBaoGiaController = TextEditingController();
  }
}
