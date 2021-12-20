

import 'package:get/get.dart';
import 'package:template/view/screen/account/capital_contribution/capital_contribution_confirmation.dart/capital_contribution_confirmation_controller.dart';

class CapitalContributionConfirmationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CapitalContributionConfirmationController>(() => CapitalContributionConfirmationController());
  }
}