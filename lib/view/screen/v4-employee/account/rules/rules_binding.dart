import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/account/rules/rules_controller.dart';

class V4RulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4RulesController>(() => V4RulesController());
  }
}
