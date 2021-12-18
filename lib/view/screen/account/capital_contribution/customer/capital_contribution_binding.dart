

import 'package:get/get.dart';
import 'package:template/view/screen/account/capital_contribution/customer/capital_contribution_controller.dart';

class CapitalContributionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CapitalContributionController>(() => CapitalContributionController());
  }
}