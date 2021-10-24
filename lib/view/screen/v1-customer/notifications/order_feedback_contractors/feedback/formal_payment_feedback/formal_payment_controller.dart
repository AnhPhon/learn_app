import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/data/repository/phan_hoi_don_dich_vu_repository.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';

class V1FormalPaymentFeedbackController extends GetxController{
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider = GetIt.I.get<PhanHoiDonDichVuProvider>();
  PhanHoiDonDichVuRepository phanHoiDonDichVuRepository = GetIt.I.get<PhanHoiDonDichVuRepository>();
  PhanHoiDonDichVuResponse? phanHoiDonDichVuResponse;

  int formalPaymentGroup = 0;
  double tongTien = 0;
  double phi = 0;
  double khuyenMai = 0;
  double soTien = 0;
  double thanhToan = 0;

  @override
  void onInit() {
    phanHoiDonDichVuResponse = Get.arguments as PhanHoiDonDichVuResponse;
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
      khuyenMai = double.parse(phanHoiDonDichVuResponse!.idDonDichVu!.khuyenMai!,(e)=> 0);
      phi = double.parse(phanHoiDonDichVuResponse!.idDonDichVu!.phiDichVu!,(e)=> 0);
      soTien = double.parse(phanHoiDonDichVuResponse!.idDonDichVu!.soTien!);
      tongTien =  soTien + phi - khuyenMai;
      if(formalPaymentGroup == 0){
        thanhToan = tongTien;
      }else{
        thanhToan = tongTien * 10 / 100;
      }
  }

  ///
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
   
    return request;
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
    PhanHoiDonDichVuRequest donPhanHoi = onRequest(); 
    await Get.toNamed("${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${thanhToan.toStringAsFixed(0)}&url=${AppRoutes.V1_DASHBOARD}")!.then((value){
        if(value == true){
          EasyLoading.show(status: "Phản hồi đơn dịch vụ thành công!");
          donPhanHoi.tinhTrangThanhToan = "61604f4cc8e6fa122227e29f";
          phanHoiDonDichVuRepository.add(donPhanHoi).then((value){
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
            print("V1FormalPaymentFeedbackController onClickPayment onError $onError");
          });
        }else{

            EasyLoading.showSuccess('Phản hồi đơn dich vụ thành công');
            //set trạng thái chưa thanh toán
            donPhanHoi.tinhTrangThanhToan= "61615180e87a9124404abe82";
            //insert db
            phanHoiDonDichVuRepository.add(donPhanHoi).then((value){
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
              print("V1FormalPaymentFeedbackController onClickPayment onError $onError");
            });

        }
      });
  }

}