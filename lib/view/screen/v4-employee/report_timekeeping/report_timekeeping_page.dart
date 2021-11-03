import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';

import 'package:template/view/screen/v4-employee/report_timekeeping/report_timekeeping_controller.dart';

class V4ReportTimekeepingPage extends GetView<V4ReportTimekeepingControllter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo cáo cuối ngày"),
      body: GetBuilder(builder: (V4ReportTimekeepingControllter controller) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),
              //chọn thời gian reprot chấm công
              _reportTimekeeping(controller, context),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //điền nội dung report chấm công
              _reportContent(controller, context),

              Container(
                height: DeviceUtils.getScaledHeight(context, .33),
              ),

              //Button báo cáo
              _btnReport(controller)
            ],
          ),
        );
      }),
    );
  }

  ///
  /// Chọn thời gian report chấm công
  ///
  Widget _reportTimekeeping(
      V4ReportTimekeepingControllter controller, BuildContext context) {
    return InputWidget(
      fillColor: ColorResources.LIGHT_GREY.withOpacity(0.8),
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      allowEdit: false,
      label: "Thời gian",
      obligatory: true,
      width: DeviceUtils.getScaledWidth(context, 1),
      textEditingController: controller.reportTimekeeping,
      suffixIcon: const Icon(
        Icons.date_range,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
    );
  }
}

///
/// Nhập nội dung báo cáo
///
Widget _reportContent(
    V4ReportTimekeepingControllter controller, BuildContext context) {
  return InputWidget(
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    maxLine: 8,
    hintText: "Vui lòng nhập nội dung báo cáo",
    fillColor: ColorResources.WHITE,
    label: 'Nội dung',
    obligatory: true,
    width: DeviceUtils.getScaledWidth(context, 1),
    textEditingController: controller.reportContent,
  );
}

///
/// Button báo cáo
///

LongButton _btnReport(V4ReportTimekeepingControllter controller) {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {
      controller.report();
    },
    title: 'Báo cáo',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}
