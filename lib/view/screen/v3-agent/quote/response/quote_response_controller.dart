import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';

class V3QuoteResponseController extends GetxController {
  String tieuDeBaoGia = "Cần báo giá xi măng";

  TextEditingController datetimeController = TextEditingController();
  TextEditingController costController = TextEditingController(text: "0");

  List<Map<String, dynamic>>? infoCard;
  bool isCheck = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    infoCard = [
      {
        "label": "Tên vật liệu",
        "value": "Xi măng",
        "input": false,
      },
      {
        "label": "Quy cách",
        "value": "Kim đỉnh",
        "input": false,
      },
      {
        "label": "Số lượng",
        "value": "5",
        "input": false,
      },
      {
        "label": "Đơn vị",
        "value": "Tấn",
        "input": false,
      },
      {
        "label": "Đơn giá",
        "value": "300.000 VND",
        "input": true,
      },
    ];
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
        datetimeController = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(_dateTime),
        );
        update();
      }
    });
  }

  ///
  /// on Cost Change
  ///
  void onCostChange(BuildContext context, String value) {
    if (value.isNotEmpty) {
      costController = TextEditingController(
        text: PriceConverter.convertPrice(context, double.parse(value)),
      );
      // update();
    }
  }

  ///
  /// on Continue Click
  ///
  void onContinueClick() {
    Get.toNamed(AppRoutes.V3_QUOTE_CHECK);
  }
}
