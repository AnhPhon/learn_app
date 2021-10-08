

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/create/g3_create_service_controller.dart';

class V1G3CreateServiceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => V1G3CreateServiceController());
  }

}