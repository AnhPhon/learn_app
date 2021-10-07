import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candicate/candicate_controller.dart';

class V1CandicateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1CandicateController>(() => V1CandicateController());
  }

}