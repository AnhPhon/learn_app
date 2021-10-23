

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class OrderInformationController extends GetxController{
  final PhanHoiDonDichVuProvider phanHoiDonDichVuProvider = GetIt.I.get<PhanHoiDonDichVuProvider>();
    PhanHoiDonDichVuResponse? donPhanHoi;

    @override
  void onInit() {
    super.onInit();
    donPhanHoi = Get.arguments as PhanHoiDonDichVuResponse;
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
      /// Phản hồi lại bên thợ thầu là có đồng ý với giá đó không
      // EasyLoading.show(status: "Phản hồi đơn dich vụ thành công");
      // phanHoiDonDichVuProvider.add(data: onRequest(), onSuccess: (data){
      //   // show snackBar 
      //   EasyLoading.dismiss();
        
      // }, onError: (onError){
      //   EasyLoading.dismiss();
      //   print("OrderInformationController onNextPage onError $onError");
      // });
      Get.toNamed(AppRoutes.V1_FORMAL_FEEDBACK_PAYMENT, arguments: donPhanHoi);

      
    }
}