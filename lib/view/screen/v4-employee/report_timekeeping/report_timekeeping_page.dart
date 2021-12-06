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

import 'package:template/view/screen/v4-employee/report_timekeeping/report_timekeeping_controller.dart';

class V4ReportTimekeepingPage extends GetView<V4ReportTimekeepingControllter> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V4ReportTimekeepingControllter>(
        init: V4ReportTimekeepingControllter(),
        builder: (V4ReportTimekeepingControllter controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: const AppBarWidget(title: "Báo cáo cuối ngày"),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //chọn thời gian reprot chấm công
                    _reportTimekeeping(controller, context),

                    // Tên dự án/văn phòng báo cáo ngày
                    _projectDailyReport(controller, context),

                    //điền nội dung report chấm công
                    _reportContent(controller, context),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, .1),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Expanded(
                            child: Text(
                              "Ứng dụng cần cung cấp quyền vị trí để định vị vị trí báo cáo cuối ngày chính xác theo dự án.",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: ColorResources.RED,
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Button báo cáo
                    _btnReport(controller),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///
  /// Chọn thời gian report chấm công
  ///
  Widget _reportTimekeeping(
      V4ReportTimekeepingControllter controller, BuildContext context) {
    return InputWidget(
      labelBold: true,
      fillColor: ColorResources.LIGHT_GREY.withOpacity(0.8),
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.FONT_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_SMALL),
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
/// tên dự án/văn phòng báo cáo theo yêu cầu
///
Widget _projectDailyReport(
    V4ReportTimekeepingControllter controller, BuildContext context) {
  return DropDownButton1<DuAnNhanVienResponse>(
    isColorFieldWhite: true,
    labelBold: true,
    hint: 'Địa điểm làm việc/văn phòng',
    label: 'Địa điểm làm việc/văn phòng',
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
Widget _reportContent(
    V4ReportTimekeepingControllter controller, BuildContext context) {
  return InputWidget(
    labelBold: true,
    padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.FONT_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL),
    isColorFieldWhite: true,
    maxLine: 11,
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

Widget _btnReport(V4ReportTimekeepingControllter controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.FONT_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL),
    child: LongButton(
      color: ColorResources.APPBARCOLOR,
      onPressed: () {
        controller.report();
      },
      title: 'Báo cáo',
    ),
  );
}
