import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/order_item_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class CartController extends GetxController {
  OrderItemProvider orderItemProvider = GetIt.I.get<OrderItemProvider>();

  //list tổng tiền
  List payment = ["Giá tiền", "Phí ship", "Khuyến mãi", "Tổng"];
  List price = ["150.000đ", "15.000đ", "-50.000đ", "115.000đ"];

  bool isLastProduct = false;

  //số lượng sản phẩm
  int qualityProduct = 1;

  //xoá khỏi giỏ hàng
  void deleteItem() {
    orderItemProvider.delete(
        id: "614418d3527c6f1c0c5980e8",
        onSuccess: (value) {
          print(value);
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

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
