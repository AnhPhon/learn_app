import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/yeu_cau_bao_gia_model.dart';
import 'package:template/utils/color_resources.dart';
import 'package:url_launcher/url_launcher.dart';

class V3QuoteCheckController extends GetxController {
  TextEditingController datetimeController = TextEditingController();
  TextEditingController costController = TextEditingController(text: "0");

  bool isCheck = true;
  List<List<Map<String, dynamic>>> infoCard = [];
  String tieuDeBaoGia = "Danh sách báo giá đơn hàng";
  String loaiCongTrinh = "Nhà tư";
  String tinhThanh = "TP. HCM";
  String quan = "Quận Gò Vấp";
  String phuong = "Phường 9";
  String diaChiCuThe = "Đường Lê Lợi, P9, Quận Gò Vấp, TP.HCM";
  String from = "25/08/2021";
  String to = "20/09/2021";
  List<String> noiDungYeuCau = [];
  List<String> images = [];
  double giaTriDonHang = 0;
  double phiGiaoHang = 0;
  String loaiHinh = "Giao gấp";
  String filepath = "";

  List<Map<String, dynamic>> features = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    features = [
      {
        "title": "Chỉnh sửa",
        "onTap": () {},
        "color": ColorResources.LIGHT_GREY
      },
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

    // load data
    final YeuCauBaoGiaModel yeuCauBaoGiaModel =
        Get.arguments as YeuCauBaoGiaModel;

    infoCard = yeuCauBaoGiaModel.infoCard ?? [];
    loaiCongTrinh = yeuCauBaoGiaModel.loaiCongTrinh ?? "";
    tinhThanh = yeuCauBaoGiaModel.tinhThanh ?? "";
    quan = yeuCauBaoGiaModel.quan ?? "";
    phuong = yeuCauBaoGiaModel.phuong ?? "";
    diaChiCuThe = yeuCauBaoGiaModel.diaChiCuThe ?? "";
    from = yeuCauBaoGiaModel.from ?? "";
    to = yeuCauBaoGiaModel.to ?? "";
    noiDungYeuCau = yeuCauBaoGiaModel.noiDungYeuCau ?? [];
    images = yeuCauBaoGiaModel.images ?? [];
    giaTriDonHang = yeuCauBaoGiaModel.giaTriDonHang ?? 0;
    tieuDeBaoGia = yeuCauBaoGiaModel.tieuDeBaoGia ?? "";

    // additional
    filepath = yeuCauBaoGiaModel.filepath.toString();
    phiGiaoHang = yeuCauBaoGiaModel.phiGiaoHang!;
    loaiHinh = yeuCauBaoGiaModel.loaiHinh.toString();

    for (int i = 0; i < infoCard.length; i++) {
      for (int j = 0; j < infoCard[i].length; j++) {
        infoCard[i][j]["input"] = false;
      }
    }

    isLoading = false;

    update();
  }

  ///
  /// get filename by filepath
  ///
  String getFilename(String filePath) {
    return filePath.split("/").last;
  }

  ///
  ///onBtnDownCv
  ///
  Future<void> onBtnDownload({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
