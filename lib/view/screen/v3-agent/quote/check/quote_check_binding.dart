import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/quote/check/quote_check_controller.dart';

class V3QuoteCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V3QuoteCheckController>(() => V3QuoteCheckController());
  }
}
