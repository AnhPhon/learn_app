import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/screen/v4-employee/report/add_report/add_report_on_request/add_report_on_request_controller.dart';

class V4AddReportOnRequestPage extends GetView<V4AddReportOnRequestController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V4AddReportOnRequestController>(
      init: V4AddReportOnRequestController(),
      builder: (V4AddReportOnRequestController controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Scaffold(
                appBar: const AppBarWidget(title: "Báo cáo theo yêu cầu"),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      //chọn thời gian báo cáo theo yêu cầu
                      _timeReportOnRequest(controller, context),

                      // Tên dự án/văn phòng báo cáo theo yêu cầu
                      _projectReportOnRequest(controller, context),

                      //nhập nội dung báo cáo theo yêu cầu
                      _contentReportOnRequest(controller, context),

                      //button báo cáo theo yêu cầu
                      _btnReport(controller),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}

///
/// Chọn thời gian báo cáo theo yêu cầu
///
Widget _timeReportOnRequest(
    V4AddReportOnRequestController controller, BuildContext context) {
  return InputWidget(
    labelBold: true,
    label: 'Thời gian',
    textEditingController: controller.timeReportOnRequest,
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
Widget _projectReportOnRequest(
    V4AddReportOnRequestController controller, BuildContext context) {
  return DropDownButton1<DuAnNhanVienResponse>(
    isColorFieldWhite: true,
    labelBold: true,
    hint: 'Vui lòng chọn dự án',
    label: 'Tên dự án',
    data: controller.duAnNhanVienListAdd,
    obligatory: true,
    onChanged: (value) => controller.onChangedDuAnNhanVien(value!),
    value: controller.duAnNhanVienAdd,
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
Widget _contentReportOnRequest(
    V4AddReportOnRequestController controller, BuildContext context) {
  return InputWidget(
    labelBold: true,
    textEditingController: controller.contentReportOnRequest,
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

Widget _btnReport(V4AddReportOnRequestController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.FONT_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL),
    child: LongButton(
      color: ColorResources.PRIMARY,
      onPressed: () {
        controller.onBaoCao();
      },
      title: 'Báo cáo',
    ),
  );
}
