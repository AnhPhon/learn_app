import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v4-employee/report_timekeeping/report_timekeeping_controller.dart';

class V4ReportTimekeepingPage extends GetView<V4ReportTimekeepingControllter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo cáo cuối ngày"),
      body: GetBuilder(builder: (V4ReportTimekeepingControllter controller) {
        // if (controller.isLoading) {
        //   return const Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        return Column(
          children: [
            //chọn thời gian reprot chấm công
            _reportTimekeeping(controller, context),

            //điền nội dung report chấm công
            _reportContent(controller, context),

            Container(
              height: DeviceUtils.getScaledHeight(context, .4),
            ),

            //Button báo cáo
            _btnReport()
          ],
        );
      }),
    );
  }

  ///
  /// Chọn thời gian report chấm công
  ///
  Widget _reportTimekeeping(
      V4ReportTimekeepingControllter controller, BuildContext context) {
    return TextFieldDate(
      paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      isDate: true,
      allowEdit: true,
      controller: controller.reportTimekeeping,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      holdplacer: "12-11-2021",
      label: "Thời gian",
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }
}

///
/// Nhập nội dung báo cáo
///
InputField _reportContent(
    V4ReportTimekeepingControllter controller, BuildContext context) {
  return InputField(
    // ignore: avoid_redundant_argument_values
    line: 5,
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

LongButton _btnReport() {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {},
    title: 'Báo cáo',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}