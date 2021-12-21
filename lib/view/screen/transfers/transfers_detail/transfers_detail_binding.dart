

import 'package:get/get.dart';
import 'package:template/view/screen/transfers/transfers_detail/transfers_detail_controller.dart';

class TransfersDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TransfersDetailController>(() => TransfersDetailController());
  }
}