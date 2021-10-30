import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2WorkPreviewController extends GetxController {
  ///
  /// go to done page
  ///
  void toDonePage() {
    Get.toNamed(AppRoutes.V2_REGISTER_DONE);
  }
}
