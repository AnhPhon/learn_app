import 'package:get/get.dart';
import 'package:template/view/screen/v3-agent/quote/request/quote_request_controller.dart';

class V3QuoteRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<V3QuoteRequestController>(() => V3QuoteRequestController());
  }
}
