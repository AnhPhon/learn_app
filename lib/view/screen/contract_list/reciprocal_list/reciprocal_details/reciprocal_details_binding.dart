import 'package:get/get.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/reciprocal_details/reciprocal_details_controller.dart';

class ReciprocalDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReciprocalDetailsController>(() => ReciprocalDetailsController());
  }
}
