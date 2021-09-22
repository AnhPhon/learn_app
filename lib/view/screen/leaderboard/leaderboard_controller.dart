import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class LeaderBoardController extends GetxController {
  String title = "commodo elit at imperdiet dui accumsan sit";
  String subtitle =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.";

  void onChartsClick() {
    Get.toNamed(AppRoutes.CHARTS);
  }

  void onBtnHomeClick() {
    Get.to(PostsPage());
  }

  //  money normalize
  String moneyNormalize(int money, String splitSymbol) {
    String text = money.toString().split('').reversed.join();
    int size = text.length;

    String result = "";
    int mark = 0;
    for (int i = 0; i < size; i++) {
      mark += 1;
      result = text[i] + result;

      if (mark % 3 == 0) {
        result = splitSymbol + result;
      }
    }

    if (result[0] == splitSymbol) result = result.substring(1, result.length);

    return result;
  }
}
