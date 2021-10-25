import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';

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
                height: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              //chọn thời gian reprot chấm công
              _reportTimekeeping(controller, context),

              //điền nội dung report chấm công
              _reportContent(controller, context),

              Container(
                height: DeviceUtils.getScaledHeight(context, .27),
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
InputField _reportContent(
    V4ReportTimekeepingControllter controller, BuildContext context) {
  return InputField(
    isColorFieldWhite: false,
    line: 10,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.reportContent,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: 'Nhập nội dung báo cáo',
    label: 'Nội dung',
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
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
