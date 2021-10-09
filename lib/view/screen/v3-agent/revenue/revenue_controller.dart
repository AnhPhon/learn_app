import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class V3RevenueController extends GetxController {
  final startController = TextEditingController();
  final endController = TextEditingController();

  String title = "Doanh thu";

  List<RevenueData> revenueDataList = [
    RevenueData(
      "Tổng doanh thu các đơn hàng",
      100,
      Colors.primaries[Random().nextInt(Colors.primaries.length)],
    ),
    RevenueData(
      "Phí dịch vụ",
      39,
      Colors.primaries[Random().nextInt(Colors.primaries.length)],
    ),
    RevenueData(
      "Thuế được khấu trừ (nếu có)",
      10,
      Colors.primaries[Random().nextInt(Colors.primaries.length)],
    ),
    RevenueData(
      "Thuế khác(nếu có)",
      8,
      Colors.primaries[Random().nextInt(Colors.primaries.length)],
    ),
    RevenueData(
      "Lợi nhuận",
      42,
      Colors.primaries[Random().nextInt(Colors.primaries.length)],
    ),
  ];
}

class RevenueData {
  RevenueData(this.unit, this.money, this.color);
  final String unit;
  final double money;
  final Color color;
}
