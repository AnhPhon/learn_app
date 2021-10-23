


import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1OrderFeedBackController extends GetxController{
  PhanHoiDonDichVuResponse? donPhanHoi;
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  // Khối lương công việc
  List<VatTuResponse> workMass = [];
  bool isLoading = true;
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;
  @override
  void onInit() {
    if(Get.arguments != null){
      donPhanHoi = Get.arguments as PhanHoiDonDichVuResponse;
      soTien = double.parse(donPhanHoi!.idDonDichVu!.soTien!,(e)=> 1000000000);
      phiDichVu = double.parse(donPhanHoi!.idDonDichVu!.phiDichVu!,(e)=> 1000000000);
      khuyenMai = double.parse(donPhanHoi!.idDonDichVu!.khuyenMai!,(e)=> 1000000000);
      tongTien = soTien + phiDichVu + khuyenMai;
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
    Get.toNamed(AppRoutes.V1_FEEDBACK_ORDER_INFORAMTION, arguments: donPhanHoi);
  }
}