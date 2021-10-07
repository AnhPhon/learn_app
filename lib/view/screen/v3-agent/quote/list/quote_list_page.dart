import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/quote/list/quote_list_controller.dart';

class V3QuoteListPage extends GetView<V3QuoteListController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarWidget(title: "Danh sách báo giá đơn hàng"),
      body: GetBuilder<V3QuoteListController>(
        init: V3QuoteListController(),
        builder: (V3QuoteListController controller) {
          return const Center(
            child: Text("quote list page"),
          );
        },
      ),
    );
  }
}
