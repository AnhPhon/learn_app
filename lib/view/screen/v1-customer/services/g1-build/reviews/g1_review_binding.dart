

import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g1-build/reviews/g1_review_controller.dart';

class V1G1ReviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G1ReviewController>(() => V1G1ReviewController());
  }

}