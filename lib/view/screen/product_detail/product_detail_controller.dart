import 'package:get/get.dart';

class ProductDetailController extends GetxController {
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
