import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class HomeController extends GetxController {
  List banner = [Images.banner1, Images.banner2, Images.banner3];

  int categoryPages = 0;

  bool isCategory = false;

  void onBtnHomeClick() {
    Get.to(PostsPage());
  }

  void onRegisterIdClick() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  void onBtnCategoriesClick(int? index) {
    isCategory = false;
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

  void onProductVoucherClick() {
    isCategory = true;
    Get.toNamed(AppRoutes.CATEGORIES);
  }

  void onBtnCategoriesDetailClick() {
    Get.toNamed(AppRoutes.CATEGORY_DETAIL);
  }

  void onProductClick() {
    Get.toNamed(AppRoutes.PRODUCT_DETAIL);
  }

  void onGroupClick() {
    Get.toNamed(AppRoutes.GROUP);
  }
}
