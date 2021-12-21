

import 'package:get/get.dart';
import 'package:template/view/screen/transfers/transfers_status/fail/transfers_fail_controller.dart';

class TransfersFailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TransfersFailController>(() => TransfersFailController());
  }
}