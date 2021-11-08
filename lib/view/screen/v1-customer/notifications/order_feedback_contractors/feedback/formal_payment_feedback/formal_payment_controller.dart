import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/repository/don_dich_vu_repository.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';

class V1FormalPaymentFeedbackController extends GetxController{
  DonDichVuRepository donDichVuRepository = GetIt.I.get<DonDichVuRepository>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse? donDichVu;

  int formalPaymentGroup = 0;
  double soTien = 0;
  double thanhToan = 0;
  double tienCoc = 0;

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
      soTien = double.parse(donDichVu!.tongDon!);
      tienCoc = double.parse(donDichVu!.tienCoc!,(e)=> 0);
      if(formalPaymentGroup == 0){
        thanhToan = soTien;
      }else{
        thanhToan = soTien * 10 / 100;
      }
  }


  void onClickContinueButton() {
    //set value tuyendung
    final DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest.id = donDichVu!.id;

    Get.toNamed(
            '${AppRoutes.ORDER_INFORMATION}?soTien=${thanhToan.toStringAsFixed(0)}&tienCoc=${tienCoc.toStringAsFixed(0)}')!
        .then((value) => {
              //đã thanh toán
              if (value != null && value['type'] == 1)
                {
                  //set trạng thái đã thanh toán
                  dichVuRequest.idTrangThaiThanhToan = DA_THANH_TOAN,
                  dichVuRequest.idTrangThaiDonDichVu = CHOT_GIA,
                  dichVuRequest.phiDichVu = value['phiDichVu'].toString(),
                  dichVuRequest.khuyenMai = value['khuyenMai'].toString(),
                  dichVuRequest.tongDon = value['tongTien'].toString(),
                  //insert db
                  donDichVuRepository.add(dichVuRequest).then((value) => {
                        if (value.response.data != null)
                          {
                            Get.offAllNamed(AppRoutes.V1_DASHBOARD, predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD)),
                            Get.back(),
                            Get.back(),
                            Alert.success(
                                message: 'Phản hồi dịch vụ thành công'),
                          }
                        else
                          Alert.error(message: 'Vui lòng thực hiện lại')
                      })
                }
              //chưa thanh toán
              else if (value != null && value['type'] == 2)
                {
                  //set trạng thái chưa thanh toán
                  dichVuRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN,
                  // dichVuRequest.idTrangThaiDonDichVu = CHOT_GIA,
                  // dichVuRequest.phiDichVu = value['phiDichVu'].toString(),
                  // dichVuRequest.khuyenMai = value['khuyenMai'].toString(),
                  // dichVuRequest.tongDon = value['tongTien'].toString(),
                  //insert db
                  donDichVuRepository.add(dichVuRequest).then((value) => {
                        if (value.response.data != null)
                          {
                            Get.offAllNamed(AppRoutes.V1_DASHBOARD, predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD)),
                            Get.back(),
                            Get.back(),
                            Alert.success(
                                message: 'Phản hồi dịch vụ thất bại'),
                          }
                        else
                          {Alert.error(message: 'Vui lòng thực hiện lại')}
                      })
                }
            });
  }


}