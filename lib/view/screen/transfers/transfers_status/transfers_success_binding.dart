

import 'package:get/get.dart';
import 'package:template/view/screen/transfers/transfers_status/transfers_success_controller.dart';

class TransfersSuccessBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TransfersSuccessController>(() => TransfersSuccessController());
  }
}