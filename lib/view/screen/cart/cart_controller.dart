import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class CartController extends GetxController {
  //list tổng tiền
  List payment = ["Giá tiền", "Phí ship", "Khuyến mãi", "Tổng"];
  List price = ["150.000đ", "15.000đ", "-50.000đ", "115.000đ"];

  bool isLastProduct = false;

  //số lượng sản phẩm
  int qualityProduct = 1;

  //tăng số lượng
  void incrementQuality() {
    qualityProduct += 1;
    update();
  }

  //giảm số lượng
  void decrementQuality() {
    qualityProduct -= 1;
    update();
  }

  void onBtnHomeClick() {
    Get.to(PostsPage());
  }

  //thanh toán
  void onCheckoutClick() {
    Get.toNamed(AppRoutes.CHECKOUT);
  }

  //thay đổi địa chỉ
  void onAddressClick() {
    Get.toNamed(AppRoutes.ADDRESS);
  }
}
