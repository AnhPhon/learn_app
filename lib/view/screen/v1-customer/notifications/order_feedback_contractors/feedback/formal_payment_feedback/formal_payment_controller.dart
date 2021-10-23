import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';

class V1FormalPaymentFeedbackController extends GetxController{
  
  PhanHoiDonDichVuProvider dichVuProvider = GetIt.I.get<PhanHoiDonDichVuProvider>();
  PhanHoiDonDichVuResponse? phanHoiDonDichVuResponse;

  int formalPaymentGroup = 0;
  double tongTien = 0;
  @override
  void onInit() {
    phanHoiDonDichVuResponse = Get.arguments as PhanHoiDonDichVuResponse;
    if(formalPaymentGroup == 0){
      tongTien = double.parse(phanHoiDonDichVuResponse!.idDonDichVu!.tongDon!, (e)=> 1000000000);
    }else{
      tongTien = double.parse(phanHoiDonDichVuResponse!.idDonDichVu!.tongDon!, (e)=> 1000000000) * 10 /100;
    }
    super.onInit();
  }

  ///
  /// change formal payment
  ///
  void onChangedFormalPayment(int val){
    formalPaymentGroup = val;
    update();
  }

  ////////////////////////////////////////////////////////////////
  /// Tạo request
  /// 
  PhanHoiDonDichVuRequest onRequest(){
    PhanHoiDonDichVuRequest request =  PhanHoiDonDichVuRequest();
    //phanHoiDonDichVuResponse!.idDonDichVu!.tieuDe = "Phản hồi báo giá đơn dich vụ "
    if(phanHoiDonDichVuResponse!.idDonDichVu!.id != null){
      request.idDonDichVu = phanHoiDonDichVuResponse!.idDonDichVu!.id;
    }
    if(phanHoiDonDichVuResponse!.idDonDichVu!.idTaiKhoan != null){
      // Tài khoản nhận đơn
      request.idTaiKhoan = phanHoiDonDichVuResponse!.idTaiKhoan!.id;
    }
    // if(phanHoiDonDichVuResponse!.idTaiKhoan!.id != null){
    //   request.idTaiKhoan = phanHoiDonDichVuResponse!.idTaiKhoan!.id;
    // }
    return request;
  }

  void showDialogAccept() {
    Get.defaultDialog(
        title: "Xác nhận thông tin",
        content: DialogContentPriceAccept(
          textContent:
              'Bạn chắc chắn đồng ý thanh toán',
          price: tongTien,
        ),
        confirm: ElevatedButton(
            onPressed: () {
              onClickPayment();
            },
            child: const Text("Đồng ý")),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorResources.GREY,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text("Hủy")));
  }

  void onClickPayment()async{
    // Đên tài khoản của tôi để thanh toán
    await Get.toNamed("${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${tongTien.toStringAsFixed(0)}&url=${AppRoutes.V1_DASHBOARD}")!.then((value){
        if(value == true){
            EasyLoading.show(status: "Phản hồi thành công!");
            dichVuProvider.add(data: onRequest(), onSuccess: (data){
              // show snackBar 
              EasyLoading.dismiss();
              Get.toNamed(AppRoutes.V1_FORMAL_FEEDBACK_PAYMENT, arguments: phanHoiDonDichVuResponse);
            }, onError: (onError){
              EasyLoading.dismiss();
              print("OrderInformationController onNextPage onError $onError");
            });
        }
      });
  }

}