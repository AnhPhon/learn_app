import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/label_input.dart';
import 'package:template/view/screen/v1-customer/quote/request1/request_controller.dart';

class V1Request1Page extends GetView<V1Request1Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1Request1Controller>(
      init: V1Request1Controller(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                children: [
                  // tieu de bao gia
                  _tieuDeBaoGia(),

                  SizedBox(height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT),),

                  // tieu de bao gia
                  _tieuDeBaoGia(),
                ],
              ),
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
