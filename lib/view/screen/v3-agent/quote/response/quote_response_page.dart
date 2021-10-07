import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/quote/response/quote_response_controller.dart';

class V3QuoteResponsePage extends GetView<V3QuoteResponseController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarWidget(title: "Danh sách báo giá đơn hàng"),
      body: GetBuilder<V3QuoteResponseController>(
        init: V3QuoteResponseController(),
        builder: (V3QuoteResponseController controller) {
          return const Center(
            child: Text("quote Response page"),
          );
        },
      ),
    );
  }
}
