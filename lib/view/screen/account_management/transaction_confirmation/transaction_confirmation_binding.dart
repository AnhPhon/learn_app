import 'package:get/get.dart';
import 'package:template/view/screen/account_management/transaction_confirmation/transaction_confirmation_controller.dart';

class TransactionConfirmationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionConfirmationController>(() => TransactionConfirmationController());
  }
}
