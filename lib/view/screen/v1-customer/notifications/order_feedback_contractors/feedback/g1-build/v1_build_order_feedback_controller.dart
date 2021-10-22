

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/app_constants.dart';

class V1BuildOrderFeedBackController extends GetxController{
  final VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  PhanHoiDonDichVuResponse? donPhanHoi;
  // Khối lương công việc
  List<VatTuResponse> workMass = [];
  bool isLoading = true;

  @override
  void onInit() {
    if(Get.arguments != null){
      donPhanHoi = Get.arguments as PhanHoiDonDichVuResponse;
    }
    super.onInit();
    getJobMass();
  }

  ///
  /// Lấy báo giá công việc or vâtk liệu thuộc đơn dịch vụ
  ///
  void getJobMass(){
    vatTuProvider.paginate(page: 1, limit: 100, filter: '&idDonDichVu=${donPhanHoi!.idDonDichVu!.id!}', onSuccess: (data){
      workMass.clear();
      workMass.addAll(data);
      isLoading = false;
      update();
    }, onError: (onError){
      isLoading = false;
      update();
      print("V1OrderFeedBackController getJobMass onError $onError");
    });
  }

  void onClickAgreeButton(){
    // Đến màn hình chọn phương thức thanh toán
    Get.toNamed(AppRoutes.V1_ORDER_INFORAMTION, arguments: donPhanHoi);
  }
}