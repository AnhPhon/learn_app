import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/quote/check/quote_check_controller.dart';

class V3QuoteCheckPage extends GetView<V3QuoteCheckController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarWidget(title: "Danh sách báo giá đơn hàng"),
      body: GetBuilder<V3QuoteCheckController>(
        init: V3QuoteCheckController(),
        builder: (V3QuoteCheckController controller) {
          return const Center(
            child: Text("quote Check page"),
          );
        },
      ),
    );
  }
}
