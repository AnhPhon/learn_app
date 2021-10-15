import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:template/routes/app_routes.dart';


class V2WorkRegisterController extends GetxController {
  String title = "Đăng ký việc";

  TextEditingController? tieuDeBaoGiaController;
  TextEditingController? loaiCongTrinh;

  TextEditingController? fromDate;
  TextEditingController? toDate;

  TextEditingController? nhomCongViec;
  TextEditingController? congViecPhuHop;
  TextEditingController? toanTinh;

  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();


  List<String>? currencies;
  String? firstSelect;

  // radio
  //List<SelectProvinceCustomModel>? provinceData;
  // List<SelectProvinceCustomModel>? provinceData;
  List<bool>? checkList;

  @override
  void onInit() {
    super.onInit();
    checkList = [false, false, false, false];

    firstSelect = "Công trình 1";
    currencies = ["Công trình 1", "Công trình 2", "Công trình 3"];

    tieuDeBaoGiaController = TextEditingController();
    loaiCongTrinh = TextEditingController(text: firstSelect);

    nhomCongViec = TextEditingController(text: firstSelect);
    congViecPhuHop = TextEditingController(text: firstSelect);
    toanTinh = TextEditingController(text: firstSelect);

    fromDate = TextEditingController();
    toDate = TextEditingController();

    // provinceData = [
    //   SelectProvinceCustomModel(
    //     value: "TP.HCM",
    //     onChanged: (val) {
    //       onChange(0, val as bool);
    //     },
    //   ),
    //   SelectProvinceCustomModel(
    //     value: "Hà Nội",
    //     onChanged: (val) {
    //       onChange(1, val as bool);
    //     },
    //   ),
    //   SelectProvinceCustomModel(
    //     value: "Đà Nẵng",
    //     onChanged: (val) {
    //       onChange(2, val as bool);
    //     },
    //   ),
    //   SelectProvinceCustomModel(
    //     value: "Tỉnh khác",
    //     onChanged: (val) {
    //       onChange(3, val as bool);
    //     },
    //   ),
    // ];
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
  void onChange(int index, dynamic value) {
    checkList![index] = value as bool;
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
  /// continue
  ///
  void nextPage() {
    Get.toNamed(AppRoutes.V1_QUOTE_REQUEST_2);
  }

  ///
  /// datePicker
  ///
  void datePicker(BuildContext context, DateTime firstDate, DateTime lastDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime(2021, 10, 7),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((_dateTime) {
      if (_dateTime != null) {
        timeStartController = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(_dateTime),
        );
        update();
      }
    });
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
