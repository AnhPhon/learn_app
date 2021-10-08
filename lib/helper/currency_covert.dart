

import 'package:intl/intl.dart';

class CurrencyConverter {
  static String currencyConverterVND(double value){
    return NumberFormat.currency(name: "",decimalDigits: 0).format(value);
  }
}