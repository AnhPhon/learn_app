import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class HomeController extends GetxController {
  //banner
  List banner = [Images.banner1, Images.banner2, Images.banner3];

  int categoryPages = 0;

  void onBtnHomeClick() {
    Get.to(PostsPage());
  }

  // tạo id
  void onRegisterIdClick() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  //danh mục
  void onBtnCategoriesClick(int? index) {
    if (index == 0) {
      categoryPages = 0;
    } else if (index == 1) {
      categoryPages = 1;
    } else if (index == 2) {
      categoryPages = 2;
    } else if (index == 3) {
      categoryPages = 3;
    } else if (index == 4) {
      categoryPages = 4;
    } else if (index == 5) {
      categoryPages = 5;
    } else {
      categoryPages = 0;
    }
    Get.toNamed(AppRoutes.CATEGORIES);
  }

  //kho hàng trợ giá
  void onProductVoucherClick() {
    Get.toNamed(AppRoutes.KHOHANGTROGIA);
  }

  // kho hàng điều kiện
  void onBtnKhoHangDieuKienClick() {
    Get.toNamed(AppRoutes.KHOHANGDIEUKIEN);
  }

  //đội nhóm
  void onGroupClick() {
    Get.toNamed(AppRoutes.GROUP);
  }
}
