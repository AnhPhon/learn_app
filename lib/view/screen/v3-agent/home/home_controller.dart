import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3HomeController extends GetxController {
  String fullname = "KH, Nguyễn Văn A";

  ///
  /// click to store page
  ///
  void onStorePageClick() {
    Get.toNamed(AppRoutes.V3_STORE);
  }
}
