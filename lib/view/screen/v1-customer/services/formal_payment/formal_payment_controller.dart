import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1FormalPaymentController extends GetxController {
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuRequest? dichVuRequest;

  int formalPaymentGroup = 0;

  @override
  void onInit() {
    // dichVuRequest = Get.arguments as DonDichVuRequest;
    super.onInit();
  }

  ///
  /// change formal payment
  ///
  void onChangedFormalPayment(int val) {
    formalPaymentGroup = val;
    update();
  }

  void onClickPayment() {
    // Đên tài khoản của tôi để thanh toán
    //Get.toNamed(AppRoutes.V1_ORDER_INFORAMTION);
    Get.offAllNamed(AppRoutes.V1_DASHBOARD,
        predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD));
  }
}
