import 'package:get/get.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/voucher_routers.dart';

class VoucherController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///Go to Detail Voucher
  ///
  void goToDetailVoucher() {
    Get.toNamed(VoucherRouters.DETAIL_VOUCHER)!.then((value) {
      if (!IZIValidate.nullOrEmpty(value) && value == true) {
        onInit();
        update();
      }
    });
    update();
  }
}
