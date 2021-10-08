

import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/cv/preview/preview_controller.dart';

class V2PreviewBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<V2PreviewController>(() => V2PreviewController());
  }
}