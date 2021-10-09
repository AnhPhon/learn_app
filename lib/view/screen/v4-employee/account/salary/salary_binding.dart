import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/account/salary/salary_controller.dart';

class V4SalaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4SalaryController>(() => V4SalaryController());
  }
}
