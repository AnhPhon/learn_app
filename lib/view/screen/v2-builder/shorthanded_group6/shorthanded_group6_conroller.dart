import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedGroup6Controller extends GetxController {
  String title = "Dịch vụ đang cần báo giá";

  ///
  ///on btn edit click
  ///
  void onBtnEditClick() {
    Get.back();
  }

  ///
  ///on btn quotation click
  ///
  void onBtnQuotationClick() {
    Get.offNamed(AppRoutes.V2_QUOTATION_GROUP56);
  }
}
