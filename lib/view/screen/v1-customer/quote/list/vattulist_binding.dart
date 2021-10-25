import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/quote/list/vattulist_controller.dart';

class V1VatTuListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V1VatTuListController>(() => V1VatTuListController());
  }
}
