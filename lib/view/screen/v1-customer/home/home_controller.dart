import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1HomeController extends GetxController {
  String fullname = "KH, Nguyễn Văn A";

  ///
  /// go to Form Management Page
  ///
  void onClickFormManagementPage() {
    Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT);
  }

  ///
  /// go to Form List Page
  ///
  void onClickFormList() {
    Get.toNamed(AppRoutes.V1_FORM_LIST);
  }

  ///
  /// go to Product Page
  ///
  void onMoreProductList() {
    Get.toNamed(AppRoutes.V1_PRODUCT);
  }
}
