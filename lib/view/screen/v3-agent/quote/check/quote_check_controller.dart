import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/yeu_cau_bao_gia_model.dart';

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
  String title = "Yêu cầu báo giá";
  List<String>? noiDungYeuCau;
  List<Map<String, dynamic>>? features;
  List<String> images = [];
  double giaTriDonHang = 0;

  YeuCauBaoGiaModel? yeuCauBaoGiaModel;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    // load data
    loadData();
  }

  ///
  /// load data
  ///
  void loadData() {
    yeuCauBaoGiaModel = Get.arguments as YeuCauBaoGiaModel;
    infoCard = yeuCauBaoGiaModel!.infoCard!;
    loaiCongTrinh = yeuCauBaoGiaModel!.loaiCongTrinh!;
    tinhThanh = yeuCauBaoGiaModel!.tinhThanh!;
    quan = yeuCauBaoGiaModel!.quan!;
    phuong = yeuCauBaoGiaModel!.phuong!;
    diaChiCuThe = yeuCauBaoGiaModel!.diaChiCuThe!;
    from = yeuCauBaoGiaModel!.from!;
    to = yeuCauBaoGiaModel!.to!;
    title = yeuCauBaoGiaModel!.title!;
    noiDungYeuCau = yeuCauBaoGiaModel!.noiDungYeuCau;
    features = yeuCauBaoGiaModel!.features;
    images = yeuCauBaoGiaModel!.images!;
    giaTriDonHang = yeuCauBaoGiaModel!.giaTriDonHang!;
    tieuDeBaoGia = yeuCauBaoGiaModel!.tieuDeBaoGia!;

    isLoading = false;

    update();
  }
}
