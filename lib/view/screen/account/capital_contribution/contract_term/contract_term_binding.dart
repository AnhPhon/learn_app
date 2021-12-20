

import 'package:get/get.dart';
import 'package:template/view/screen/account/capital_contribution/contract_term/contract_term_controller.dart';

class ContractTermBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContractTermController>(() => ContractTermController());
  }
}