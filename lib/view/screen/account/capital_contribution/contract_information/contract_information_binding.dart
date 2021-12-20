

import 'package:get/get.dart';
import 'package:template/view/screen/account/capital_contribution/contract_information/contract_information_controller.dart';

class ContractInformationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContractInformationController>(() => ContractInformationController());
  }
}