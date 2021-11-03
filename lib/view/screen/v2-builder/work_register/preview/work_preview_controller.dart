import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/routes/app_routes.dart';

class V2WorkPreviewController extends GetxController {
  ///
  /// go to done page
  ///
  void toDonePage() {
    Get.toNamed(AppRoutes.V2_REGISTER_DONE);
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToVNDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }
}
