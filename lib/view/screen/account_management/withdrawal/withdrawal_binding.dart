import 'package:get/get.dart';
import 'package:template/view/screen/account_management/withdrawal/withdrawal_controller.dart';

class WithdrawalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawalController>(() => WithdrawalController());
  }
}
