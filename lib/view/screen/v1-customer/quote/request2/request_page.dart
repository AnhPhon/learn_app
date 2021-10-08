import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/label_input.dart';
import 'package:template/view/screen/v1-customer/quote/request2/request_controller.dart';

class V1Request2Page extends GetView<V1Request2Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1Request2Controller>(
      init: V1Request2Controller(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        );
      },
    );
  }

  ///
  /// tiêu đề báo giá
  ///
  Widget _tieuDeBaoGia() {
    return LabelInput(
      label: "Tiêu đề báo giá",
      labelText: "Tiêu đề báo giá",
      controller: controller.tieuDeBaoGiaController!,
      isRequire: true,
    );
  }
}
