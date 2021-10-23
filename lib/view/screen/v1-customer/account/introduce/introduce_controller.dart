import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';

class V1IntroduceController extends GetxController {
  String title = "Giới thiệu FSS";

  String urlImage =
      "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  String gif =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, ";

  ///
  ///copy
  ///
  void onBtnCopyClick() {
    Clipboard.setData(const ClipboardData(text: "http://izisoft.io/"));

    //show snackbar
    Get.showSnackbar(GetBar(
      message: "Copied",
      backgroundColor: ColorResources.BLACK.withOpacity(.3),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 1000),
    ));
  }
}
