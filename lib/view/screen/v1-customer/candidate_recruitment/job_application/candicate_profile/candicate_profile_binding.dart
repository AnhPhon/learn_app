import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/job_application/candicate_profile/candicate_profile_controller.dart';

class V1CandicateProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1CandicateProfileController>(() => V1CandicateProfileController());
  }

}