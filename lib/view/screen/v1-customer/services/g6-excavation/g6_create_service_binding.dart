
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g6-excavation/g6_create_service_controller.dart';

class V1G6CreateServiceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G6CreateServiceController>(() => V1G6CreateServiceController());
  }

}