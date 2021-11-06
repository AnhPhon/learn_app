import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/quote/list/quote_list_controller.dart';

class V3QuoteListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V3QuoteListController>(() => V3QuoteListController());
  }
}
