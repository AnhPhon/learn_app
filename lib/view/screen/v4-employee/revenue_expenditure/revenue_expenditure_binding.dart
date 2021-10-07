import 'package:get/get.dart';
import 'package:template/view/screen/v4-employee/revenue_expenditure/revenue_expenditure_controller.dart';

class V4RevenueExpenditureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V4RevenueExpenditureController>(
        () => V4RevenueExpenditureController());
  }
}
