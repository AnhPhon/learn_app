import 'package:tiengviet/tiengviet.dart';

class Validate {
  final RegExp reg = RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  static bool oneUpperCase(String text) {
    final RegExp reg = RegExp(r'^(?=.*?[A-Z])\w+$');
    if (reg.hasMatch(text)) {
      // có it nhất 1 chữ hoà
      return true;
    } else {
      // không có
      return false;
    }
  }

  ///
  /// Validate lower
  ///
  static bool oneLowerCase(String text) {
    //(?=.*?[a-z])

    print(text);
    final RegExp reg = RegExp(r'(?=.*[a-z])\w+$');
    if (reg.hasMatch(text)) {
      // có it nhất 1 chữ thường
      return true;
    } else {
      // không có
      return false;
    }
  }

  ///
  ///Validate number
  ///
  static bool leastOneDigit(String text) {
    final RegExp reg = RegExp(r'^(?=.*?[0-9])\w+$');
    if (reg.hasMatch(text)) {
      // it nhất 1 số
      return true;
    } else {
      // không có
      return false;
    }
  }

  ///
  /// validate special character
  ///
  static bool specialCharacter(String text) {
    final RegExp reg = RegExp(r'^(?=.*?[!@#\$&*~])$');
    if (reg.hasMatch(text)) {
      // it nhất 1 số
      return true;
    } else {
      // không có
      return false;
    }
  }

  ///
  /// validate Must be at least 8 characters in length
  ///
  static bool charactersLength(String text) {
    final RegExp reg = RegExp(r'^.{8,}$');
    if (reg.hasMatch(text)) {
      // it nhất 1 số
      return true;
    } else {
      // không có
      return false;
    }
  }

  ///
  /// Validate email
  ///
  static bool email(String text) {
    // a-zA-Z0-9 : cho phep a - Z 0 -9
    // + @(Bắt buộc )
    final RegExp reg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (reg.hasMatch(text)) {
      // email hợp lệ
      return true;
    } else {
      // không hợp lệ
      return false;
    }
  }

  ///
  /// Validate phone
  ///
  static bool phone(String text) {
    //r'^([+0]9)?[0-9]{10}$'
    final RegExp reg = RegExp(r'^([+0])\d{9}$');
    if (reg.hasMatch(text)) {
      // email hợp lệ
      return true;
    } else {
      // phone không hợp lệ
      return false;
    }
  }

  static bool checkValueIsNullEmpty(dynamic value) {
    if (value == null || value.toString().isEmpty || value.toString() == 'null' || (value is List && value.isEmpty == true)) return true;
    return false;
  }

  static String getValuePriceString(dynamic value) {
    if (value == null || value.toString().isEmpty || value.toString() == 'null' || (value is List && value.isEmpty == true)) return '0';
    final String result = value.toString().replaceAll('.', '').replaceAll(',', '').replaceAll('null', '');
    if(result == '') return '0';
    return result;
  }

  static String removeVietnameseTones(String str) {
    final _str = TiengViet.parse(str.toLowerCase()).toLowerCase();
    return _str;
  }

  static String getGenderString(dynamic value) {
    if (checkValueIsNullEmpty(value) == true) return 'Không xác định';

    if (value == 1 || value == '1') {
      return "Nam";
    } else if (value == 2 || value == '2') {
      return "Nữ";
    } else if (value == 2 || value == '3') {
      return "Tất cả";
    }
    return 'Không xác định';
  }

  static String getGenderValue(dynamic value) {
    if (checkValueIsNullEmpty(value) == true) return '3';

    if (value.runtimeType == String) {
      if (value.toString().contains('Nam')) {
        return "1";
      } else if (value.toString().contains('Nữ')) {
        return "2";
      }
      return '3';
    }
    return '3';
  }
}
