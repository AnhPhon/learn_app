import 'package:get/get.dart';
import 'package:template/view/screen/contract_list/list_of_interest_payments/list_of_interest_payments_controller.dart';

class ListOfInterestPaymentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListOfInterestPaymentsController>(() => ListOfInterestPaymentsController());
  }
}
