import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedGroup2Controller extends GetxController {
  String title = "Công việc đang cần người";

  ///
  ///go to quotation g2 page
  ///
  void onQuotationG2PageClick() {
    Get.toNamed(AppRoutes.V2_QUOTATION_GROUP2);
  }
}
