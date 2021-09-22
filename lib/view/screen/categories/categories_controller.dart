import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class CategoriesController extends GetxController {
  final List<Map> myCategories =
      List.generate(10, (index) => {"id": index, "name": "Product $index"})
          .toList();

  List<String> categoriesName = [
    "Nước giặt",
    "Viên nén",
    "Kiềm",
    "Viên Hàn Lâm",
    "Hoá mỹ phẩm",
    "Khác",
  ];

  List nameProduct = [
    'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
    'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
    'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
    'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
    'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
    'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG'
  ];
  int categorySelectedIndex = 0;

  void onBtnDetailClick() {
    Get.toNamed(AppRoutes.CATEGORY_DETAIL);
  }

  void changeSelectedIndex(int selectedIndex) {
    categorySelectedIndex = selectedIndex;
    update();
  }

  void onProductClick() {
    Get.toNamed(AppRoutes.PRODUCT_DETAIL);
  }
}
