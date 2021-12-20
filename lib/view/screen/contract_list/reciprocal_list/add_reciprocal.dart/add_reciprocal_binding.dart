import 'package:get/get.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/add_reciprocal.dart/add_reciprocal_controller.dart';

class AddReciprocalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddReciprocalController>(() => AddReciprocalController());
  }
}
