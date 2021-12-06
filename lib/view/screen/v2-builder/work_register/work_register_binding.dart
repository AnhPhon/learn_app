import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_controller.dart';
import 'package:template/view/screen/v2-builder/work_register/work_register_controller.dart';

class V2WorkRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V2WorkRegisterController>(() => V2WorkRegisterController());
    Get.lazyPut<AppBarController>(() => AppBarController());
  }
}
