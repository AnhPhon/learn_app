import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class CategoriesController extends GetxController {
  final List<Map> myCategories =
      List.generate(4, (index) => {"id": index, "name": "Product $index"})
          .toList();

  List<String> categoriesName = [
    "Kiềm",
    "Dầu gội",
    "Lau sàn",
    "Sữa tắm",
    "Khác"
  ];
  int categorySelectedIndex = 0;

  void onBtnDetailClick() {
    Get.toNamed(AppRoutes.CATEGORY_DETAIL);
  }

  void changeSelectedIndex(int selectedIndex) {
    categorySelectedIndex = selectedIndex;
    update();
  }
}
