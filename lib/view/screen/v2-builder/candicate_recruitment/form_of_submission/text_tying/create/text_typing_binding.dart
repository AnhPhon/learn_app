

import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/text_tying/create/text_typing_controller.dart';

class V2TextTypingBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<V2TextTypingController>(() => V2TextTypingController());
  }
}