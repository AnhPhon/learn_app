import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2HomeController extends GetxController {
  String fullname = "KH, Nguyễn Văn A";

  ///
  ///go to product page
  ///
  void onProductPageClick() {
    Get.toNamed(AppRoutes.V2_PRODUCT);
  }
}
