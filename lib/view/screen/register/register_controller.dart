// ignore_for_file: type_annotate_public_apis

import 'package:get/get.dart';

typedef Ham = void Function(int);
class RegisterController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "1".obs;

  int sum = 0;

  // ignore: use_setters_to_change_properties
  void setSelected(String value) {
    selected.value = value;
  }
  
  // ignore: always_declare_return_types
  Ham? them(int val){
    sum += val;
  }
  
  //  money normalize
  String moneyNormalize(double money, String splitSymbol) {
    final String text = money.toString().split('.')[0].split('').reversed.join();
    final int size = text.length;

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
