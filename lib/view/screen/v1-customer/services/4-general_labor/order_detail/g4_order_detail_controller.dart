import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1G4OrderDetailController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuRequest? donDichVuRequest;
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;

  @override
  void onInit() {
    super.onInit();
    donDichVuRequest = Get.arguments as DonDichVuRequest;
    if (donDichVuRequest != null) {
      soTien = double.parse(donDichVuRequest!.soTien!,(e)=> 0);
      phiDichVu = double.parse(donDichVuRequest!.phiDichVu!,(e)=> 0);
      khuyenMai = double.parse(donDichVuRequest!.khuyenMai!,(e)=> 0);
      tongTien = soTien + phiDichVu - khuyenMai;
    }
  }

  void onNextPage(){
    Get.toNamed(AppRoutes.V1_FORMAL_PAYMENT, arguments: donDichVuRequest);
  }

}