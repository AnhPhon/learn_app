import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';

import 'package:template/view/basewidget/button/long_button.dart';

import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v4-employee/timekeeping/timekeeping_controller.dart';

class V4TimekeepingPage extends GetView<V4TimekeepingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Thông tin chấm công",
      ),
      body: GetBuilder<V4TimekeepingController>(
          init: V4TimekeepingController(),
          builder: (V4TimekeepingController controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // chọn thời gian chấm công
                  _timekeeping(controller, context),

                  //dự án
                  _project(context),

                  //địa chỉ
                  _address(controller, context),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //thành phố
                      _city(context),

                      //quận/huyện
                      _district(context),
                    ],
                  ),
                  Container(
                    height: DeviceUtils.getScaledHeight(context, .3),
                  ),
                  _btnTimekeeping(),
                ],
              ),
            );
          }),
    );
  }

  ///
  /// Chọn thời gian chấm công
  ///
  Widget _timekeeping(
      V4TimekeepingController controller, BuildContext context) {
    return TextFieldDate(
      paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      isDate: true,
      allowEdit: true,
      controller: controller.timekeeping,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      holdplacer: "12-11-2021",
      label: "Thời gian",
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }

  ///
  /// dự án
  ///
  DropDownButton<String> _project(BuildContext context) {
    return DropDownButton<String>(
      label: 'Dự án(nếu có)',
      data: const ['Dự án A', "Dự án C"],
      obligatory: true,
      onChanged: (value) {},
      value: 'Dự án A',
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }

  ///
  /// Địa chỉ
  ///
  Widget _address(V4TimekeepingController controller, BuildContext context) {
    return InputField(
      allowEdit: true,
      allowMultiline: false,
      controller: controller.address,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      hidden: false,
      holdplacer: 'Da Nang Ciy',
      label: 'Địa chỉ',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }
}

///
/// Tỉnh /Tp
///
Widget _city(BuildContext context) {
  return DropDownButton<String>(
    hint: 'Tỉnh/Tp',
    data: const ['Đà Nẵng', "Huế"],
    obligatory: true,
    onChanged: (value) {},
    value: 'Đà Nẵng',
    width: DeviceUtils.getScaledWidth(context, 0.5),
  );
}

///
/// Quận/Huyện
///
Widget _district(BuildContext context) {
  return DropDownButton<String>(
    hint: 'Quyện/Huyện',
    data: const ['Hải Châu', "Cẩm Lệ"],
    obligatory: true,
    onChanged: (value) {},
    value: 'Hải Châu',
    width: DeviceUtils.getScaledWidth(context, 0.5),
  );
}

///
/// Button chấm công
///
Widget _btnTimekeeping() {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {},
    title: 'Chấm công',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}
