import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/quote/response/quote_response_controller.dart';

class V3QuoteResponseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V3QuoteResponseController>(() => V3QuoteResponseController());
  }
}
