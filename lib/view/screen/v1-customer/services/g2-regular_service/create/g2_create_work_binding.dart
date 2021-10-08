
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g2-regular_service/create/g2_create_work_controller.dart';

class V1G2CreateWorkBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G2CreateWorkController>(() => V1G2CreateWorkController());
  }

}