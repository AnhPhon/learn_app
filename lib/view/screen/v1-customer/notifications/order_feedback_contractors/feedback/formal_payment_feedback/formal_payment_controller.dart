import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/repository/don_dich_vu_repository.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';

class V1FormalPaymentFeedbackController extends GetxController{
  DonDichVuRepository donDichVuRepository = GetIt.I.get<DonDichVuRepository>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse? donDichVu;

  int formalPaymentGroup = 0;
  double tongTien = 0;
  double phi = 0;
  double khuyenMai = 0;
  double soTien = 0;
  double thanhToan = 0;

  @override
  void onInit() {
    donDichVu = Get.arguments as DonDichVuResponse;
    tinhTien();
    super.onInit();
  }

  ///
  /// change formal payment
  ///
  void onChangedFormalPayment(int val){
    formalPaymentGroup = val;
    tinhTien();
    update();
  }

  void tinhTien(){
      khuyenMai = double.parse(donDichVu!.khuyenMai!,(e)=> 0);
      phi = double.parse(donDichVu!.phiDichVu!,(e)=> 0);
      soTien = double.parse(donDichVu!.soTien!);
      tongTien =  soTien + phi - khuyenMai;
      if(formalPaymentGroup == 0){
        thanhToan = tongTien;
      }else{
        thanhToan = tongTien * 10 / 100;
      }
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

  void onClickPayment()async{
    // Đên tài khoản của tôi để thanh toán
    await Get.toNamed("${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${thanhToan.toStringAsFixed(0)}&url=${AppRoutes.V1_DASHBOARD}")!.then((value){
        if(value == true){
          EasyLoading.show(status: "Phản hồi đơn dịch vụ thành công!");
          updateDon(status: DA_THANH_TOAN,serviceStatus: DA_PHAN_HOI);
        }else{
            EasyLoading.showSuccess('Phản hồi đơn thất bại');
            //set trạng thái chưa thanh toán
            updateDon(status: CHUA_THANH_TOAN, serviceStatus: CHUA_PHAN_HOI);
        }
      });
  }

  ///
  /// Update 
  ///
  void updateDon({required String status,required String serviceStatus}){
    final DonDichVuRequest request =  DonDichVuRequest();
    request.id = donDichVu!.id;
    //request.idTaiKhoan = donDichVu!.idTaiKhoan!.id;
    request.idTrangThaiDonDichVu = serviceStatus;
    request.idTrangThaiThanhToan = status;
    print(request.toJson());
    donDichVuProvider.update(data: request, onSuccess: (onSuccess){
      EasyLoading.dismiss();
      Get.offAllNamed(AppRoutes.V1_DASHBOARD, predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD));
      // TODO
      Get.back();
    }, onError: (onError){
        EasyLoading.dismiss();
        print("V1FormalPaymentFeedbackController onClickPayment onError $onError");
    });
  }

}