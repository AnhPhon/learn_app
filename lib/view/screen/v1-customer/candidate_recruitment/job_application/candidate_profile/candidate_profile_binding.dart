import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/job_application/candidate_profile/candidate_profile_controller.dart';

class V1CandidateProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1CandidateProfileController>(() => V1CandidateProfileController());
  }

}