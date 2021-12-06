import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_daily_report/add_daily_report_controller.dart';

class V4AddDailyReportPage extends GetView<V4AddDailyReportController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V4AddDailyReportController>(
      init: V4AddDailyReportController(),
      builder: (V4AddDailyReportController controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Scaffold(
              appBar: const AppBarWidget(title: "Báo cáo ngày"),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //chọn thời gian báo cáo ngày
                    _timeDailyReport(controller, context),

                    // Tên dự án/văn phòng báo cáo ngày
                    _projectDailyReport(controller, context),

                    //nhập nội dung báo cáo ngày
                    _contentDailyReport(controller, context),

                    //button báo cáo theo yêu cầu
                    _btnReport(controller, context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

///
/// Chọn thời gian báo cáo theo yêu cầu
///
Widget _timeDailyReport(
    V4AddDailyReportController controller, BuildContext context) {
  return InputWidget(
    labelBold: true,
    label: 'Thời gian',
    textEditingController: controller.timeDailyReport,
    obligatory: true,
    suffixIcon: const Icon(Icons.date_range, color: ColorResources.PRIMARY),
    fillColor: ColorResources.LIGHT_GREY.withOpacity(0.4),
    allowEdit: false,
    padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.FONT_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL),
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// tên dự án/văn phòng báo cáo theo yêu cầu
///
Widget _projectDailyReport(
    V4AddDailyReportController controller, BuildContext context) {
  return DropDownButton1<DuAnNhanVienResponse>(
    isColorFieldWhite: true,
    labelBold: true,
    hint: 'Vui lòng chọn dự án',
    label: 'Tên dự án',
    data: controller.duAnNhanVienListDaily,
    obligatory: true,
    onChanged: (value) => controller.onChangedDuAnNhanVien(value!),
    value: controller.duAnNhanVienDaily,
    fillColor: ColorResources.WHITE,
    width: DeviceUtils.getScaledWidth(context, 1),
    padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.FONT_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL),
  );
}

///
/// Nhập nội dung báo cáo
///
Widget _contentDailyReport(
    V4AddDailyReportController controller, BuildContext context) {
  return InputWidget(
    labelBold: true,
    textEditingController: controller.contentDailyReport,
    label: 'Nội dung báo cáo',
    hintText: 'Nội dung báo cáo',
    obligatory: true,
    maxLine: 11,
    fillColor: ColorResources.WHITE,
    width: DeviceUtils.getScaledWidth(context, 1),
    padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.FONT_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL),
  );
}

///
/// Button báo cáo
///

Widget _btnReport(V4AddDailyReportController controller, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.FONT_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL),
    child: LongButton(
      color: ColorResources.PRIMARY,
      onPressed: () {
        controller.dailyReport();
      },
      title: 'Báo cáo',
    ),
  );
}
