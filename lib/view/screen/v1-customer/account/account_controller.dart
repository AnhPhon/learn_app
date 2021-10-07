import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1AccountController extends GetxController {
  String title = "Tài khoản";

  String urlImage =
      "https://upload.wikimedia.org/wikipedia/commons/1/1e/Default-avatar.jpg";

  String name = "username";

  String email = "email@gmail.com";

  ///
  ///go to profile page
  ///
  void onProfileClick() {
    Get.toNamed(AppRoutes.V1_PROFILE);
  }

  ///
  ///go to point-based page
  ///
  void onPointBasedPageClick() {
    Get.toNamed(AppRoutes.V1_POINT_BASED);
  }

  ///
  ///go to wallet page
  ///
  void onWalletPageClick() {
    Get.toNamed(AppRoutes.V1_WALLET);
  }

  ///
  ///go to intoduce page
  ///
  void onIntroducePageClick() {
    Get.toNamed(AppRoutes.V1_INTRODUCE);
  }

  ///
  ///go to help page
  ///
  void onHelpPageClick() {
    Get.toNamed(AppRoutes.V1_HELP);
  }

  ///
  ///go to job management page
  ///
  void onJobManagementClick() {
    Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT);
  }
}
