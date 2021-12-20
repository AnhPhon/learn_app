

import 'package:get/get.dart';
import 'package:template/view/screen/account/capital_contribution/authorized_person/authorized_person_controller.dart';

class AuthorizedPersonBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AuthorizedPersonController>(() => AuthorizedPersonController());
  }
}