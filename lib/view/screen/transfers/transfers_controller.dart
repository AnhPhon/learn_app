import 'package:get/get.dart';
import 'package:template/routes/route_path/transfers_routers.dart';

class TransfersController extends GetxController {
  final List<String> contactReceive = ["Nguyễn Văn Hùng", 'Lê Phú Quý', "Nguyễn một tỷ", 'Phạm Văn Đô La', 'Hùng Văn Tỷ Phú'];

  ///
  /// go to contact
  ///
  void onToContactPage() {
    Get.toNamed(
      TransfersRouters.CONTACT,
    );
  }

  ///
  /// go to transfer detail
  ///
  void onToTransfersDetailPage(){
    Get.toNamed(TransfersRouters.TRANSFERS_DETAIL);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
