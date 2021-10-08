import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3HomeController extends GetxController {
  String fullname = "KH, Nguyễn Văn A";

  ///
  ///go to product page
  ///
  void onProductPageClick() {
    Get.toNamed(AppRoutes.V3_PRODUCT);
  }
}
