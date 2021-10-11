import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/text_tying/preview/candidate_profile_controller.dart';

class V2PreviewProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V2PreviewProfileController>(() => V2PreviewProfileController());
  }

}