

import 'package:intl/intl.dart';

mixin CurrencyConverter {
  static String currencyConverterVND(double value){
    return NumberFormat.currency(name: "",decimalDigits: 0).format(value);
  }
}