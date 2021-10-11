import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';

class V3QuoteRequestController extends GetxController {
  String tieuDeBaoGia = "Cần báo giá xi măng";
  String loaiCongTrinh = "Nhà tư";
  String tinhThanh = "TP. HCM";
  String quan = "Quận Gò Vấp";
  String phuong = "Phường 9";
  String diaChiCuThe = "Đường Lê Lợi, P9, Quận Gò Vấp, TP.HCM";

  String from = "25/08/2021";
  String to = "20/09/2021";

  List<Map<String, dynamic>>? infoCard;

  List<String>? noiDungYeuCau;

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
    ];

    noiDungYeuCau = [
      "Yêu cầu cát sạch",
      "Xi măng kim đỉnh",
      "Gạch đại hiệp",
    ];

    features = [
      {
        "title": "Từ chối báo giá",
        "onTap": () {
          Get.back();
        },
        "color": const Color(0XFFB0BAC1)
      },
      {
        "title": "Đồng ý báo giá",
        "onTap": () {
        },
        "color": ColorResources.THEME_DEFAULT
      },
    ];
  }
}
