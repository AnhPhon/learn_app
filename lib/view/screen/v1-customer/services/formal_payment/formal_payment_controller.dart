import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/repository/don_dich_vu_repository.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';

class V1FormalPaymentController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuRepository donDichVuRepository = GetIt.I.get<DonDichVuRepository>();
  DonDichVuRequest? dichVuRequest;

  int formalPaymentGroup = 0;
  double tongTien = 0;
  double phiDichVu = 0;
  double soTien = 0;
  double khuyenMai = 0;
  double thanhToan = 0;
  @override
  void onInit() {
    dichVuRequest = Get.arguments as DonDichVuRequest;
    tinhTien();
    super.onInit();
  }

  void tinhTien(){
    if(dichVuRequest != null){
      phiDichVu = double.parse(dichVuRequest!.khuyenMai!);
      soTien = double.parse(dichVuRequest!.soTien!);
      phiDichVu = double.parse(dichVuRequest!.phiDichVu!);
      tongTien = double.parse(dichVuRequest!.tongDon!, (e)=> 0);
      if(formalPaymentGroup == 0){
        thanhToan = tongTien;
      }else{
        thanhToan = tongTien * 10 /100;
      }
    }  
  }

  ///
  /// change formal payment
  ///
  void onChangedFormalPayment(int val) {
    formalPaymentGroup = val;
    tinhTien();
    update();
  }

  void onClickPayment()async{
    // Đên tài khoản của tôi để thanh toán
    await Get.toNamed("${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${thanhToan.toStringAsFixed(0)}&url=${AppRoutes.V1_DASHBOARD}")!.then((value){
        if(value == true){
          EasyLoading.show(status: "Tạo đơn thành công!");
          dichVuRequest!.idTrangThaiThanhToan = "61604f4cc8e6fa122227e29f";
          donDichVuRepository.add(dichVuRequest!).then((value){
            if (value.response.data != null)
                {
                   EasyLoading.dismiss();
                  Get.offAllNamed(AppRoutes.V1_DASHBOARD, predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD));
                }
              else
                {
                  EasyLoading.showError(
                      'Thao tác không thành công, vui lòng liên hệ hỗ trợ');
                }
          }, onError: (onError){
            EasyLoading.dismiss();
            print("V1FormalPaymentController onClickPayment onError $onError");
          });
        }else{

            EasyLoading.showSuccess('Đăng tin thành công');
            //set trạng thái chưa thanh toán
            dichVuRequest!.idTrangThaiThanhToan = "61615180e87a9124404abe82";
            //insert db
            donDichVuRepository.add(dichVuRequest!).then((value){
                if (value.response.data != null)
                {
                  EasyLoading.dismiss();
                  Get.offAllNamed(AppRoutes.V1_DASHBOARD, predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD));
                }
              else
                {
                  EasyLoading.showError(
                      'Thao tác không thành công, vui lòng liên hệ hỗ trợ');
                }
            }, onError: (onError){
              EasyLoading.dismiss();
              print("V1FormalPaymentController onClickPayment onError $onError");
            });

        }
      });
  }

  

  void showDialogAccept() {
    Get.defaultDialog(
        title: "Xác nhận thông tin",
        content: DialogContentPriceAccept(
          textContent:
              'Bạn chắc chắn đồng ý thanh toán',
          price: thanhToan,
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


}
