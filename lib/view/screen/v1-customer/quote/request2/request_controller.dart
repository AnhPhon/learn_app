import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1Request2Controller extends GetxController {
  String title = "Yêu cầu báo giá vật liệu";

  TextEditingController? tieuDeBaoGiaController;

  TextEditingController? tenVatTuController;
  String? tenVatTuIndex;
  TextEditingController? quyCachController;
  String? quyCachIndex;
  TextEditingController? khoiLuongController;
  String? khoiLuongIndex;
  TextEditingController? donViController;
  String? donViIndex;

  List<Map<String, dynamic>>? infoCard;

  @override
  void onInit() {
    super.onInit();
    tieuDeBaoGiaController = TextEditingController();

    tenVatTuIndex = "Xi măng 1";
    tenVatTuController = TextEditingController(text: tenVatTuIndex);

    quyCachIndex = "Kim đỉnh";
    quyCachController = TextEditingController(text: quyCachIndex);

    khoiLuongIndex = "5";
    khoiLuongController = TextEditingController(text: khoiLuongIndex);

    donViIndex = "Tấn";
    donViController = TextEditingController(text: donViIndex);

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
    ];
  }

  ///
  /// onVatTuChange
  ///
  void onVatTuChange(String? value) {
    tenVatTuIndex = value;
    update();
  }

  ///
  /// onVatTuChange
  ///
  void onQuyCachChange(String? value) {
    quyCachIndex = value;
    update();
  }

  ///
  /// onVatTuChange
  ///
  void onKhoiLuongChange(String? value) {
    khoiLuongIndex = value;
    update();
  }

  ///
  /// onVatTuChange
  ///
  void onDonViChange(String? value) {
    donViIndex = value;
    update();
  }

  ///
  /// add button
  ///
  void onAddButton() {}

  ///
  /// continue
  ///
  void nextPage() {
    Get.toNamed(AppRoutes.V1_QUOTE_CHECK);
  }
}
