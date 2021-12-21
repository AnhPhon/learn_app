

import 'package:get/get.dart';
import 'package:template/view/screen/Transfers/Transfers_controller.dart';

class TransfersBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TransfersController>(() => TransfersController());
  }
}