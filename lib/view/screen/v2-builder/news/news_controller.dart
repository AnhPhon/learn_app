import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2NewsController extends GetxController {
  ///
  ///go to news detail page
  ///
  void onNewsDetailClick() {
    Get.toNamed(AppRoutes.V2_NEWS_DETAIL);
  }
}
