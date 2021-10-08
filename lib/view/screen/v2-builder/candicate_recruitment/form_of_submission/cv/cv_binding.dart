

import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/cv/cv_controller.dart';

class V2CvBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<V2CvController>(() => V2CvController());
  }
}