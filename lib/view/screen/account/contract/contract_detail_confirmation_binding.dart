

import 'package:get/get.dart';
import 'package:template/view/screen/account/contract/contract_detail_confirmation_controller.dart';

class ContractDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContractDetailController>(() => ContractDetailController());
  }
}