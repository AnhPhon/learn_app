import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/candidate_controller.dart';

class V1CandidateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1CandidateController>(() => V1CandidateController());
  }

}