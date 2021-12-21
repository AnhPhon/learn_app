

import 'package:get/get.dart';
import 'package:template/view/screen/transfers/contact/contact_controller.dart';

class ContactBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}