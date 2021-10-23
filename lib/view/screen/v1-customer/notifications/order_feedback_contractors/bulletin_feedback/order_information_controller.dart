

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class OrderFeedbackInformationController extends GetxController{
  final PhanHoiDonDichVuProvider phanHoiDonDichVuProvider = GetIt.I.get<PhanHoiDonDichVuProvider>();
    PhanHoiDonDichVuResponse? donPhanHoi;

    double soTien = 0;
    double phiDichVu = 0;
    double khuyenMai = 0;
    double tongTien = 0;
    double tienCoc = 0;

    bool isLoading = true;
    @override
  void onInit() {
    super.onInit();
    tinhTien();
    //donPhanHoi!.idDonDichVu!.tongDon = tongTien.toString();
  }

  void tinhTien(){
    donPhanHoi = Get.arguments as PhanHoiDonDichVuResponse;
    if(donPhanHoi != null){
      soTien = double.parse(donPhanHoi!.idDonDichVu!.soTien!,(e)=> 0);
      phiDichVu = double.parse(donPhanHoi!.idDonDichVu!.phiDichVu!,(e)=> 0);
      khuyenMai = double.parse(donPhanHoi!.idDonDichVu!.khuyenMai!,(e)=> 0);
      tongTien = soTien + phiDichVu - khuyenMai;
      tienCoc = double.parse(donPhanHoi!.idDonDichVu!.tienCoc!,(e)=> 0);
      isLoading = false;
      update();
    }
  }

  ////////////////////////////////////////////////////////////////
  /// Tạo request
  /// 
  PhanHoiDonDichVuRequest onRequest(){
    PhanHoiDonDichVuRequest request =  PhanHoiDonDichVuRequest();
    //donPhanHoi!.idDonDichVu!.tieuDe = "Phản hồi báo giá đơn dich vụ "
    if(donPhanHoi!.idDonDichVu!.id != null){
      request.idDonDichVu = donPhanHoi!.idDonDichVu!.id;
    }
    if(donPhanHoi!.idDonDichVu!.idTaiKhoan != null){
      // Tài khoản nhận đơn
      request.idTaiKhoan = donPhanHoi!.idTaiKhoan!.id;
    }
    // if(donPhanHoi!.idTaiKhoan!.id != null){
    //   request.idTaiKhoan = donPhanHoi!.idTaiKhoan!.id;
    // }
    return request;
  }
    ///
    /// Nhấn vào đông ý đơn hàng
    ///
    void onNextPage(){
      Get.toNamed(AppRoutes.V1_FORMAL_FEEDBACK_PAYMENT, arguments: donPhanHoi);
    }
}