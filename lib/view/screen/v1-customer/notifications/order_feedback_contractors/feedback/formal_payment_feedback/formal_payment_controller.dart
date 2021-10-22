import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1FormalPaymentFeedbackController extends GetxController{
  
  PhanHoiDonDichVuProvider dichVuProvider = GetIt.I.get<PhanHoiDonDichVuProvider>();
  PhanHoiDonDichVuResponse? phanHoiDonDichVuResponse;

  int formalPaymentGroup = 0;

  @override
  void onInit() {
    phanHoiDonDichVuResponse = Get.arguments as PhanHoiDonDichVuResponse;
    super.onInit();
  }

  ///
  /// change formal payment
  ///
  void onChangedFormalPayment(int val){
    formalPaymentGroup = val;
    update();
  }

  void onClickPayment(){
    // Đên tài khoản của tôi để thanh toán
    //Get.toNamed(AppRoutes.V1_ORDER_INFORAMTION);
    Get.offAllNamed(AppRoutes.V1_DASHBOARD, predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD));
  }

}