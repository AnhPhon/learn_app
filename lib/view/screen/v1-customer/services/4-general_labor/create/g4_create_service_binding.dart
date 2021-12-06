

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/create/g4_create_service_controller.dart';

class V1G4CreateServiceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => V1G4CreateServiceController());
  }

}