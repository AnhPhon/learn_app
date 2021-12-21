import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/routes/route_path/detailed_product_information_routers.dart';
import 'package:template/routes/route_path/shopping_cart_routers.dart';

class ShoppingCartController extends GetxController {
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
  ///Xác nhận xóa sản phẩm
  ///
  void onConfirm() {
    IZIDialog.showDialog(
      lable: "Xác nhận",
      confirmLabel: 'Đồng ý',
      description: "Bạn có muốn xóa sản phẩm này khỏi giỏ hàng của mình không?",
      onConfirm: () {
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  ///
  ///Go to chọn Voucher
  ///
  void goToChooseVoucher() {
    Get.toNamed(ShoppingCartRouters.CHOOSE_VOUCHER);
  }
}
