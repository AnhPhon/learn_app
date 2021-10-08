
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g5-car_rental/g5_create_service_controller.dart';

class V1G5CreateServiceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G5CreateServiceController>(() => V1G5CreateServiceController());
  }

}