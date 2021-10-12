import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:template/routes/app_routes.dart';

class V1Request1Controller extends GetxController {
  String title = "Yêu cầu báo giá vật liệu";
  TextEditingController? tieuDeBaoGiaController;
  TextEditingController? loaiCongTrinh;

  TextEditingController? fromDate;
  TextEditingController? toDate;

  List<String>? currencies;
  String? firstSelect;

  // radio
  List<SelectProvinceCustomModel>? provinceData;
  dynamic selectIndex;

  @override
  void onInit() {
    super.onInit();

    firstSelect = "Công trình 1";
    currencies = ["Công trình 1", "Công trình 2", "Công trình 3"];

    tieuDeBaoGiaController = TextEditingController();
    loaiCongTrinh = TextEditingController(text: firstSelect);

    fromDate = TextEditingController();
    toDate = TextEditingController();

    selectIndex = "TP.HCM";
    provinceData = [
      SelectProvinceCustomModel(
        value: "TP.HCM",
        onChanged: (val) => onChange,
      ),
      SelectProvinceCustomModel(
        value: "Hà Nội",
        onChanged: onChange,
      ),
      SelectProvinceCustomModel(
        value: "Đà Nẵng",
        onChanged: onChange,
      ),
    ];
  }

  ///
  /// on change
  ///
  void onLoaiCongTrinhChange(String? value) {
    loaiCongTrinh = TextEditingController(text: value);
    update();
  }

  ///
  /// onChange
  ///
  void onChange(dynamic value) {
    selectIndex = value;
    update();
  }

  ///
  /// date from Picker
  ///
  void dateFromPicker(
      BuildContext context, DateTime firstDate, DateTime lastDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime(2021, 10, 7),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((_dateTime) {
      if (_dateTime != null) {
        fromDate = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(_dateTime),
        );
        update();
      }
    });
  }

  ///
  /// date to Picker
  ///
  void dateToPicker(
      BuildContext context, DateTime firstDate, DateTime lastDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime(2021, 10, 7),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((_dateTime) {
      if (_dateTime != null) {
        toDate = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(_dateTime),
        );
        update();
      }
    });
  }

  ///
  /// continue
  ///
  void nextPage() {
    Get.toNamed(AppRoutes.V1_QUOTE_REQUEST_2);
  }
}

class SelectProvinceCustomModel {
  String value;
  Function(dynamic) onChanged;

  SelectProvinceCustomModel({
    required this.value,
    required this.onChanged,
  });
}
