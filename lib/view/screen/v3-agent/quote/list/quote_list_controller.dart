import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3QuoteListController extends GetxController {
  String title = "Danh sách báo giá đơn hàng";

  ///
  /// go to reponse page
  ///
  void toReponse() {
    Get.toNamed(AppRoutes.V3_QUOTE_RESPONSE);
  }
}
