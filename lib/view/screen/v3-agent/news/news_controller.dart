import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3NewsController extends GetxController {
  String title = "Tin tức";

  ///
  ///go to news detail page
  ///
  void onNewsDetailClick() {
    Get.toNamed(AppRoutes.V3_NEWS_DETAIL);
  }
}
