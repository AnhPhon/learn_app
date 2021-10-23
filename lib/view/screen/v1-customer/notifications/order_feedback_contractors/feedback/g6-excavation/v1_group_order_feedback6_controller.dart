

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/app_constants.dart';

class V1GroupOrderFeedBack6Controller extends GetxController{
  final PhanHoiDonDichVuProvider phanHoiDonDichVuProvider = GetIt.I.get<PhanHoiDonDichVuProvider>();

  final desController = TextEditingController();

  PhanHoiDonDichVuResponse? donPhanHoi;
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;


  @override
  void onInit() {
    if(Get.arguments != null){
      donPhanHoi = Get.arguments as PhanHoiDonDichVuResponse;
      soTien = double.parse(donPhanHoi!.idDonDichVu!.soTien!,(e)=> 0);
      phiDichVu = double.parse(donPhanHoi!.idDonDichVu!.phiDichVu!,(e)=> 0);
      khuyenMai = double.parse(donPhanHoi!.idDonDichVu!.khuyenMai!,(e)=> 0);
      tongTien = soTien + phiDichVu - khuyenMai;
    }
    super.onInit();
  }

  ///
  /// Tạo request
  /// 
  PhanHoiDonDichVuRequest onRequest(){
    PhanHoiDonDichVuRequest request =  PhanHoiDonDichVuRequest();
    if(donPhanHoi!.idDonDichVu!.id != null){
      request.idDonDichVu = donPhanHoi!.idDonDichVu!.id;
    }
    if(desController.text.toString().isNotEmpty){
      //Nội dung chi tiết giá
      request.khachHangDanhGia = desController.text.toString();
    }
    if(donPhanHoi!.idDonDichVu!.idTaiKhoan != null){
      // Tài khoản nhận đơn
      request.idTaiKhoan = donPhanHoi!.idTaiKhoan!.id;
    }
    return request;
  }

  void onClickAgreeButton(){
    // Đến màn hình chọn phương thức thanh toán
    Get.toNamed(AppRoutes.V1_FORMAL_FEEDBACK_PAYMENT, arguments: donPhanHoi);
  }
  
}