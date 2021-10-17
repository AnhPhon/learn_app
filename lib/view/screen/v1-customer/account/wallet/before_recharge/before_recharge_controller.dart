import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class V1BeforeRechargeController extends GetxController {
  final amountOfMoneyController = TextEditingController();

  List optionList = [
    "100,000",
    "200,000",
    "500,000",
    "1,000,000",
    "2,000,000",
    "5,000,000",
  ];

  int? indexSelected;

  String title = "Nạp tiền";

  bool isShow = false;

  ///
  ///set show/hide
  ///
  void setShow() {
    isShow = !isShow;
    update();
  }

  ///
  ///set index selected
  ///
  void setIndexSelected({required int index}) {
    indexSelected = index;
    amountOfMoneyController.text = optionList[index].toString();
    update();
  }

  ///
  ///on changed text controller
  ///
  void onChanged(BuildContext context, dynamic value) {
    amountOfMoneyController.text.replaceAll(",", "");
    indexSelected = -1;
    update();
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    // Handle "deletion" of separator character
    final String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');
    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }
    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      final int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');
      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }
      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }
    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
