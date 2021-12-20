import 'package:get/get.dart';
import 'package:template/view/screen/contract_list/contract_list_controller.dart';

class ContractListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactListController>(() => ContactListController());
  }
}
