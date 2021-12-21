import 'package:get/get.dart';
import 'package:template/view/screen/shopping_cart/choose_voucher/choose_voucher_controller.dart';

class ChooseVoucherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseVoucherController>(() => ChooseVoucherController());
  }
}
