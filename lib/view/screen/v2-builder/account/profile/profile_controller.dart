import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2ProfileController extends GetxController {
  String title = "Hồ sơ cá nhân";

  ///
  ///go to contract page
  ///
  void onRegisterAndCommitPageClick() {
    Get.toNamed(AppRoutes.V2_REGISTER_AND_COMMIT);
  }

  ///
  ///go to contract page
  ///
  void onContractPageClick() {
    Get.toNamed(AppRoutes.V2_CONTRACT);
  }

  ///
  ///go to accident insurance page
  ///
  void onAccidentInsurancePageClick() {
  }

  ///
  ///go to other insurance page
  ///
  void onOtherInsurancePageClick() {
    Get.toNamed(AppRoutes.V2_OTHER_INSURANCE);
  }

  ///
  ///go to tax page
  ///
  void onTaxPageClick() {
    Get.toNamed(AppRoutes.V2_TAX);
  }
}
