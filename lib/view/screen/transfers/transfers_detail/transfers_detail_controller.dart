import 'package:get/get.dart';
import 'package:template/routes/route_path/transfers_routers.dart';

class TransfersDetailController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  ///
  /// go to transfer confirm
  ///
  void onToTransfersDetailPage() {
    Get.toNamed(
      TransfersRouters.TRANSFERS_CONFIRM,
    );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
