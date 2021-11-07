import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
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
import 'package:template/view/screen/v4-employee/report/add_report/add_daily_report/add_daily_report_controller.dart';

class V4AddDailyReportPage extends GetView<V4AddDailyReportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo cáo tuần"),
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
  return InputWidget(
    label: 'Ngày',
    textEditingController: controller.timeDailyReport,
    obligatory: true,
    suffixIcon: const Icon(Icons.date_range,color: ColorResources.PRIMARY),
    isDate: false,
    fillColor: ColorResources.LIGHT_GREY.withOpacity(0.7),
    allowEdit: false,
    padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// tên dự án/văn phòng báo cáo theo yêu cầu
///
Widget _projectReportOnRequest(
    V4AddDailyReportController controller, BuildContext context) {
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
    padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
  );
}

///
/// Nhập nội dung báo cáo
///
Widget _contentReportOnRequest(
    V4AddDailyReportController controller, BuildContext context) {
  return InputWidget(
    textEditingController: controller.contentDailyReport,
    label: 'Nội dung báo cáo',
    hintText: 'Nội dung báo cáo',
    obligatory: true,
    maxLine: 7,
    width: DeviceUtils.getScaledWidth(context, 1),
    padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL, right: Dimensions.PADDING_SIZE_SMALL),
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
