import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedGroup5Controller extends GetxController {
  String title = "Dịch vụ đang gọi";

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
