import 'package:get/get.dart';

class V1ContractController extends GetxController {
  bool isChecked1 = false;

  bool isChecked2 = false;

  String title = "Hợp đồng nguyên tắc với FSS";

  String content =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap intoelectronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing \nLorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and \nscrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of";

  ///
  ///set selected checkBox
  ///
  void setSeletedCheckBox1({bool? value}) {
    isChecked1 = value!;
    update();
  }

  ///
  ///set selected checkBox
  ///
  void setSeletedCheckBox2({bool? value}) {
    isChecked2 = value!;
    update();
  }
}
