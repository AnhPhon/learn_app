import 'package:get/get.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class CartController extends GetxController {
  List payment = ["Giá tiền", "Phí ship", "Khuyến mãi", "Tổng"];
  List price = ["150.000đ", "15.000đ", "-50.000đ", "115.000đ"];
  bool isLastProduct = false;
  int qualityProduct = 1;

  void incrementQuality() {
    qualityProduct += 1;
    update();
  }

  void decrementQuality() {
    qualityProduct -= 1;
    update();
  }

  void onBtnHomeClick() {
    Get.to(PostsPage());
  }
}
