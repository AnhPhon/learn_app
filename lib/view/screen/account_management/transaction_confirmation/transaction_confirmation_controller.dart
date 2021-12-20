import 'package:get/get.dart';
import 'package:template/routes/route_path/home_routes.dart';

class TransactionConfirmationController extends GetxController {
  //Khai báo isLoading
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///Go to Home
  ///
  void goToHome() {
    Get.toNamed(HomeRoutes.DASH_BOARD);
  }
}
