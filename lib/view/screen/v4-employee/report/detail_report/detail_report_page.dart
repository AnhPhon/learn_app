
import 'package:flutter/cupertino.dart';
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
import 'detail_report_controller.dart';

class V4DetailReportPage extends GetView<V4DetailReportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo cáo theo yêu cầu"),
      body: SingleChildScrollView(
          child: GetBuilder<V4DetailReportController>(
              init: V4DetailReportController(),
              builder: (V4DetailReportController controller) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //chọn thời gian báo cáo theo yêu cầu
                      _timeDetailReport(controller, context),

                      // Tên dự án/văn phòng báo cáo theo yêu cầu
                      _projectDetailReport(controller, context),

                      //nhập nội dung báo cáo theo yêu cầu
                      _contentDetailReport(controller, context),

                      Container(
                        height: DeviceUtils.getScaledWidth(context, 0.6),
                      ),
                      //button cập nhật
                      _btnUpdateDetailReport(controller,context),
                    ],
                  ),
                );
              })),
    );
  }

  ///
  /// thời gian chi tiết báo cáo
  ///
  Widget _timeDetailReport(V4DetailReportController controller,
      BuildContext context) {
    return InputWidget(
      label: 'Ngày',
      textEditingController: controller.timeDetailReport,
      obligatory: true,
      suffixIcon: const Icon(Icons.date_range, color: ColorResources.PRIMARY),
      isDate: false,
      fillColor: ColorResources.LIGHT_GREY.withOpacity(0.7),
      allowEdit: false,
      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL),
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }

  ///
  /// tên dự án/văn phòng báo cáo theo yêu cầu
  ///
  Widget _projectDetailReport(V4DetailReportController controller,
      BuildContext context) {
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
      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL),
    );
  }

  ///
  /// Nhập nội dung báo cáo
  ///
  Widget _contentDetailReport(V4DetailReportController controller,
      BuildContext context) {
    return InputWidget(
      textEditingController: controller.contentDetailReport,
      label: 'Nội dung báo cáo',
      hintText: 'Nội dung báo cáo',
      obligatory: true,
      maxLine: 7,
      width: DeviceUtils.getScaledWidth(context, 1),
      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL),
    );
  }

  ///
  /// Button cập nhập
  ///
  Widget _btnUpdateDetailReport(V4DetailReportController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_LARGE,
      ),
      child: LongButton(
        color: ColorResources.PRIMARY,
        onPressed: () {
          controller.onUpdate(context);
        },
        title: 'Cập nhập',
      ),
    );
  }
}
