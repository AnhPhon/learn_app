import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3AccountController extends GetxController {
  String title = "Tài khoản";

  String urlImage =
      "https://upload.wikimedia.org/wikipedia/commons/1/1e/Default-avatar.jpg";

  String name = "username";

  String email = "email@gmail.com";

  ///
  ///go to profile page
  ///
  void onProfileClick() {
    Get.toNamed(AppRoutes.V3_PROFILE);
  }

  ///
  ///go to point-based page
  ///
  void onPointBasedPageClick() {
    Get.toNamed(AppRoutes.V3_POINT_BASED);
  }

  ///
  ///go to wallet page
  ///
  void onWalletPageClick() {
    Get.toNamed(AppRoutes.V3_WALLET);
  }

  ///
  ///go to rules page
  ///
  void onRulesPageClick() {
    Get.toNamed(AppRoutes.V3_RULES);
  }

  ///
  ///go to intoduce page
  ///
  void onIntroducePageClick() {
    Get.toNamed(AppRoutes.V3_INTRODUCE);
  }

  ///
  ///go to help page
  ///
  void onHelpPageClick() {
    Get.toNamed(AppRoutes.V3_HELP);
  }

  ///
  ///go to job management page
  ///
  void onJobManagementClick() {
    Get.toNamed(AppRoutes.V3_JOB_MANAGEMENT);
  }
}
