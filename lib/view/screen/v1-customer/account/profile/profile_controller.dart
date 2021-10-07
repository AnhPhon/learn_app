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
  ///go to tax page
  ///
  void onTaxPageClick() {
    Get.toNamed(AppRoutes.V1_TAX);
  }
}
