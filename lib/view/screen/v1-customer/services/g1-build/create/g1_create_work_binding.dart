

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/create/g1_create_work_controller.dart';

class V1G1CreateWorkBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => V1G1CreateWorkController());
  }

}