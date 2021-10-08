
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/reviews/g7_review_controller.dart';

class V1G7ReviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G7ReviewController>(() => V1G7ReviewController());
  }

}