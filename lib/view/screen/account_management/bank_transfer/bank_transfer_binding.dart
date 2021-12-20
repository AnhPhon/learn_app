import 'package:get/get.dart';
import 'package:template/view/screen/account_management/bank_transfer/bank_transfer_controller.dart';

class BankTransferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankTransferController>(() => BankTransferController());
  }
}
