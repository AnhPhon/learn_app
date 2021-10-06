import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1NewsController extends GetxController {
  String title = "Tin tức";

  ///
  ///go to news detail page
  ///
  void onNewsDetailClick() {
    Get.toNamed(AppRoutes.V1_NEWS_DETAIL);
  }
}
