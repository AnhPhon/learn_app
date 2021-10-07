import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v4-employee/export_import/export_import_controller.dart';

class V4ExportImportPage extends GetView<V4ExportImportControleer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Xuất nhập kho"),
      body: GetBuilder(
          init: V4ExportImportControleer(),
          builder: (V4ExportImportControleer controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // chọn ngày xuất nhập kho
                      _timeExportImport(controller, context),

                      //Chọn xuất hoặc nhập kho theo trang chủ
                      if (controller.isExport == true)
                        _exprot(controller, context)
                      else
                        _import(controller, context),
                    ],
                  ),
                  // Tên dự án/kho chính sẽ được truyền vào
                  _project(controller, context),
                  InputField(
                    allowEdit: true,
                    allowMultiline: false,
                    controller: controller.suppliesController,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    hidden: false,
                    holdplacer: 'Da Nang Ciy',
                    label: 'Địa chỉ',
                    obligatory: true,
                    typeInput: TextInputType.text,
                    width: DeviceUtils.getScaledWidth(context, 1),
                  )
                ],
              ),
            );
          }),
    );
  }

  ///
  /// Chọn thời gian xuất nhập kho
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
      //boldHinText: true,
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
      // boldHinText: true,
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
