import 'package:get/get.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/reciprocal_list_controller.dart';

class ReciprocalListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReciprocalListController>(() => ReciprocalListController());
  }
}
