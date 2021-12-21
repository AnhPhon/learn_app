

import 'package:get/get.dart';
import 'package:template/view/screen/transfers/transfers_confirm/transfers_confirm_controller.dart';

class TransfersConfirmBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TransfersConfirmController>(() => TransfersConfirmController());
  }
}