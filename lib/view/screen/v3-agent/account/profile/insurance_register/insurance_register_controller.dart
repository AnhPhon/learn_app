import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3InsuranceRegisterController extends GetxController {
  String title = "Đăng ký mua bảo hiểm";

  List titleTabBar = [
    "Bảo hiểm của bạn",
    "Đăng ký mua",
  ];

  int currentIndex = 0;

  List feeList = [
    "Phí  49.500. STBH: 30.000.000",
    "Phí 83.000. STBH: 50.000.000",
    "Phí  165.500. STBH: 100.000.000",
    "Phí 660.000. STBH: 200.000.000",
  ];

  int indexFee = 0;

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  ///set selected index fee
  ///
  void setSelectedIndexFee(int? index) {
    indexFee = index!;
    update();
  }

  ///
  ///on checkout click
  ///
  void onCheckoutClick() {
    Get.toNamed(AppRoutes.V3_PAYMENT_ACCOUNT);
  }
}
