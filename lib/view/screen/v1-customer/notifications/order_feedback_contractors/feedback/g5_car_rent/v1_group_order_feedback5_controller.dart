import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1GroupOrderFeedBack5Controller extends GetxController{
  final PhanHoiDonDichVuProvider phanHoiDonDichVuProvider = GetIt.I.get<PhanHoiDonDichVuProvider>();

  PhanHoiDonDichVuResponse? donPhanHoi;

  @override
  void onInit() {
    if(Get.arguments != null){
      donPhanHoi = Get.arguments as PhanHoiDonDichVuResponse;
    }
    super.onInit();
  }

  ///
  /// Tạo request
  /// 
  PhanHoiDonDichVuRequest onRequest(){
    final PhanHoiDonDichVuRequest request =  PhanHoiDonDichVuRequest();
    if(donPhanHoi!.idDonDichVu!.id != null){
      request.idDonDichVu = donPhanHoi!.idDonDichVu!.id;
    }
    if(donPhanHoi!.idDonDichVu!.idTaiKhoan != null){
      // Tài khoản nhận đơn
      request.idTaiKhoan = donPhanHoi!.idTaiKhoan!.id;
    }
    return request;
  }

  void onClickAgreeButton(){
    // Đến màn hình chọn phương thức thanh toán
    EasyLoading.show(status: "Loading...");
      phanHoiDonDichVuProvider.add(data: onRequest(), onSuccess: (data){
        // show snackBar 
        EasyLoading.dismiss();
        Get.toNamed(AppRoutes.V1_FORMAL_FEEDBACK_PAYMENT, arguments: donPhanHoi);
      }, onError: (onError){
        EasyLoading.dismiss();
        print("V1GroupOrderFeedBack5Controller onClickAgreeButton onError $onError");
      }
    );
  }
}