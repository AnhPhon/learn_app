import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_report_on_request/add_report_on_request_controller.dart';
import 'package:template/view/screen/v4-employee/revenue_expenditure/revenue_expenditure_controller.dart';

class V4AddReportOnRequestPage extends GetView<V4AddReportOnRequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo cáo theo yêu cầu"),
      body: GetBuilder(
          init: V4AddReportOnRequestController(),
          builder: (V4AddReportOnRequestController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
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
                    height: DeviceUtils.getScaledWidth(context, 0.55),
                  ),
                  //button báo cáo theo yêu cầu
                  _btnReport(controller),
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
  return InputWidget(
    label: 'Ngày',
    textEditingController: controller.timeReportOnRequest,
    obligatory: true,
    suffixIcon: const Icon(Icons.date_range,color: ColorResources.PRIMARY),
    isDate: false,
    fillColor: ColorResources.LIGHT_GREY.withOpacity(0.4),
    allowEdit: false,
    padding: const EdgeInsets.symmetric(horizontal: Dimensions.FONT_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL),
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// tên dự án/văn phòng báo cáo theo yêu cầu
///
Widget _projectReportOnRequest(
    V4AddReportOnRequestController controller, BuildContext context) {
  return DropDownButton1<DuAnNhanVienResponse>(
    isColorFieldWhite: true,
    labelBold: true,
    hint: 'Vui lòng chọn dự án',
    label: 'Tên dự án',
    data: controller.duAnNhanVienList,
    obligatory: true,
    onChanged: (value) => controller.onChangedDuAnNhanVien(value!),
    value: controller.duAnNhanVien,
    width: DeviceUtils.getScaledWidth(context, 1),
    padding: const EdgeInsets.symmetric(horizontal: Dimensions.FONT_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL),
  );
}

///
/// Nhập nội dung báo cáo
///
Widget _contentReportOnRequest(
    V4AddReportOnRequestController controller, BuildContext context) {
  return InputWidget(
    textEditingController: controller.contentReportOnRequest,
    label: 'Nội dung báo cáo',
    hintText: 'Nội dung báo cáo',
    obligatory: true,
    maxLine: 7,
    fillColor: ColorResources.WHITE,
    width: DeviceUtils.getScaledWidth(context, 1),
    padding: const EdgeInsets.symmetric(horizontal: Dimensions.FONT_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_SMALL),
  );
}

///
/// Button báo cáo
///

Widget _btnReport(V4AddReportOnRequestController controller) {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {
      controller.onBaoCao();
    },
    title: 'Báo cáo',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}
