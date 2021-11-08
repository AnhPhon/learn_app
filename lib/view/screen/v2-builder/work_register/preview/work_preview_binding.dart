import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/work_register/preview/work_preview_controller.dart';

class V2WorkPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2WorkPreviewController>(() => V2WorkPreviewController());
  }
}
