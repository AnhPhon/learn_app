import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_report_on_request/add_report_on_request_controller.dart';

class V4AddReportOnRequestPage extends GetView<V4AddReportOnRequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo cáo theo yêu cầu"),
      body: GetBuilder(
          init: V4AddReportOnRequestController(),
          builder: (V4AddReportOnRequestController controller) {
            // if (controller.isLoading) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            return SingleChildScrollView(
              child: Column(
                children: [
                  //chọn thời gian báo cáo theo yêu cầu
                  _timeReportOnRequest(controller, context),

                  // Tên dự án/văn phòng báo cáo theo yêu cầu
                  _projectReportOnRequest(controller, context),

                  //nhập nội dung báo cáo theo yêu cầu
                  _contentReportOnRequest(controller, context),

                  Container(
                    height: DeviceUtils.getScaledWidth(context, 0.6),
                  ),
                  //button báo cáo theo yêu cầu
                  _btnReport(),
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
    V4AddReportOnRequestController controller, BuildContext context) {
  return TextFieldDate(
    paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
    isDate: true,
    allowEdit: true,
    controller: controller.timeReportOnRequest,
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
    V4AddReportOnRequestController controller, BuildContext context) {
  return InputField(
    allowEdit: true,
    allowMultiline: false,
    controller: controller.projectReportOnRequest,
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
    V4AddReportOnRequestController controller, BuildContext context) {
  return InputField(
    // ignore: avoid_redundant_argument_values
    line: 5,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.contentReportOnRequest,
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

Widget _btnReport() {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {},
    title: 'Báo cáo',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}