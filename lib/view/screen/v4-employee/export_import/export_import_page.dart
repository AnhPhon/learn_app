import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';

import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v4-employee/export_import/component/add_remove_count.dart';

import 'package:template/view/screen/v4-employee/export_import/component/drop_dow_button_horizontal.dart';
import 'package:template/view/screen/v4-employee/export_import/export_import_controller.dart';

class V4ExportImportPage extends GetView<V4ExportImportControleer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Xuất nhập kho"),
      body: GetBuilder(
          init: V4ExportImportControleer(),
          builder: (V4ExportImportControleer controller) {
            // if (controller.isLoading) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // chọn ngày xuất nhập kho
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: _timeExportImport(controller, context),
                      ),

                      //Chọn xuất hoặc nhập kho theo trang chủ
                      if (controller.isExport == true)
                        _exprot(controller, context)
                      else
                        _import(controller, context),
                    ],
                  ),

                  // Tên dự án/kho chính sẽ được truyền vào
                  _project(controller, context),

                  //Tên vật tư/thiết bị
                  _supplies(controller, context),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Số lượng
                      _quantity(controller, context),

                      //đơn vị
                      _unit(context),
                    ],
                  ),

                  //Nội dung khác(nếu có)
                  _ortherContent(controller, context),

                  Container(
                    height: DeviceUtils.getScaledHeight(context, 0.07),
                  ),

                  // Button thêm
                  _btnAdd(),
                ],
              ),
            );
          }),
    );
  }

  ///
  /// Chọn ngày xuất nhập kho
  ///
  Widget _timeExportImport(
      V4ExportImportControleer controller, BuildContext context) {
    return TextFieldDate(
      paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      isDate: true,
      allowEdit: true,
      controller: controller.timeExportImport,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      holdplacer: "12-11-2021",
      label: "Ngày",
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 0.5),
    );
  }

  ///
  /// Xuất được chọn ở trang chủ
  ///
  Widget _exprot(V4ExportImportControleer controller, BuildContext context) {
    return InputField(
      boldHinText: true,
      allowEdit: false,
      allowMultiline: false,
      controller: controller.exportController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      hidden: false,
      holdplacer: 'Xuất',
      label: 'Loại xuất',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 0.5),
    );
  }

  ///
  ///  Nhập được chọn ở trang Chủ
  ///
  Widget _import(V4ExportImportControleer controller, BuildContext context) {
    return InputField(
      boldHinText: true,
      allowEdit: false,
      allowMultiline: false,
      controller: controller.importController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      hidden: false,
      holdplacer: 'Nhập',
      label: 'Loại nhập',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 0.5),
    );
  }

  ///
  ///Tên dự án/kho chính sẽ được truyền vào
  ///
  Widget _project(V4ExportImportControleer controller, BuildContext context) {
    return InputField(
      allowEdit: false,
      allowMultiline: false,
      controller: controller.projectController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      hidden: false,
      holdplacer: '',
      label: 'Tên dự án/Kho chính',
      obligatory: true,
      typeInput: TextInputType.number,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }
}

///
///Tên vật tư/thiết bị
///
Widget _supplies(V4ExportImportControleer controller, BuildContext context) {
  return DropDownButtonHorizontal<String>(
    value: 'Xi măng',
    data: const ['Xi măng', 'Gạch'],
    label: 'Tên vật tư/thiết bị',
    onChanged: (value) {},
    width: DeviceUtils.getScaledWidth(context, 0.5),
  );
}

///
/// Số lượng
///
Widget _quantity(V4ExportImportControleer controller, BuildContext context) {
  return AddAndRemoveCount(
    controller: controller.countController,
    allowEdit: true,
    label: 'Số lượng',
    typeInput: TextInputType.number,
    width: DeviceUtils.getScaledWidth(context, 0.25),
  );
}

///
/// Đơn vị
///
Widget _unit(BuildContext context) {
  return DropDownButton<String>(
    label: 'Đơn vị:',
    data: const ['Tấn', "Tạ", "Yến"],
    obligatory: true,
    onChanged: (value) {},
    value: 'Tấn',
    width: DeviceUtils.getScaledWidth(context, 0.4),
  );
}

///
/// Nội dung khác ( nếu có)
///
Widget _ortherContent(
    V4ExportImportControleer controller, BuildContext context) {
  return InputField(
    // ignore: avoid_redundant_argument_values
    line: 5,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.contentController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: 'Nhập nội dung khác',
    label: 'Nội dung khác(nếu có)',
    obligatory: false,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Button Thêm
///
Widget _btnAdd() {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {},
    title: 'Thêm',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}
