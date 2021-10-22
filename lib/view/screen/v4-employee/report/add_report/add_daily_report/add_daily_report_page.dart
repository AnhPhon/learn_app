import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_daily_report/add_daily_report_controller.dart';

class V4AddDailyReportPage extends GetView<V4AddDailyReportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo cáo ngày"),
      body: GetBuilder(
          init: V4AddDailyReportController(),
          builder: (V4AddDailyReportController controller) {
            // if (controller.isLoading) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            return SingleChildScrollView(
              child: Column(
                children: [
                  //chọn thời gian báo cáo ngày
                  _timeReportOnRequest(controller, context),

                  // Tên dự án/văn phòng báo cáo ngày
                  _projectReportOnRequest(controller, context),

                  //nhập nội dung báo cáo ngày
                  _contentReportOnRequest(controller, context),

                  Container(
                    height: DeviceUtils.getScaledWidth(context, 0.6),
                  ),
                  //button báo cáo theo yêu cầu
                  _btnReport(controller, context),
                ],
              ),
            );
          }),
    );
  }
}

///
/// Chọn thời gian báo cáo theo yêu cầu
///
Widget _timeReportOnRequest(
    V4AddDailyReportController controller, BuildContext context) {
  return TextFieldDate(
    paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
    isDate: true,
    allowEdit: true,
    controller: controller.timeDailyReport,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    holdplacer: "12-11-2021",
    label: "Ngày",
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// tên dự án/văn phòng báo cáo theo yêu cầu
///
Widget _projectReportOnRequest(
    V4AddDailyReportController controller, BuildContext context) {
  return InputField(
    allowEdit: true,
    allowMultiline: false,
    controller: controller.projectDailyReport,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: 'Dự án A',
    label: 'Tên dự án/văn phòng',
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Nhập nội dung báo cáo
///
InputField _contentReportOnRequest(
    V4AddDailyReportController controller, BuildContext context) {
  return InputField(
    // ignore: avoid_redundant_argument_values
    line: 5,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.contentDailyReport,
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

Widget _btnReport(V4AddDailyReportController controller, BuildContext context) {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {
      controller.dailyReport();
    },
    title: 'Báo cáo',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}
