import 'package:get/get.dart';
import 'package:template/data/model/response/dang_ky_bao_hiem_response.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1ProfileController extends GetxController {
  //DangKyBaoHiem
  DangKyBaoHiemProvider dangKyBaoHiemProvider = DangKyBaoHiemProvider();
  DangKyBaoHiemResponse dangKyBaoHiemResponse = DangKyBaoHiemResponse();

  //tile appbar
  String title = "Hồ sơ cá nhân";

  ///
  ///go to contract page
  ///
  void onContractPageClick() {
    Get.toNamed(AppRoutes.V1_CONTRACT);
  }

  ///
  ///go to accident insurance page
  ///
  void onAccidentInsurancePageClick() {
    Get.toNamed(AppRoutes.V1_ACCIDENT_INSURANCE);
  }

  ///
  ///go to other insurance page
  ///
  void onOtherInsurancePageClick() {
    Get.toNamed(AppRoutes.V1_OTHER_INSURANCE);
  }

  ///
  ///go to tax page
  ///
  void onTaxPageClick() {
    Get.toNamed(AppRoutes.V1_TAX);
  }
}
