import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1ProfileController extends GetxController {
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
