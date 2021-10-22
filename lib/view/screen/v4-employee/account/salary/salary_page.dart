import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
import 'package:template/view/screen/v4-employee/account/salary/salary_controller.dart';

class V4SalaryPage extends GetView<V4SalaryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Bảng lương"),
      body: GetBuilder<V4SalaryController>(
          init: V4SalaryController(),
          builder: (V4SalaryController controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: Dimensions.PADDING_SIZE_LARGE,
                ),
                //chọn thời gian xem lương
                _timeSalary(controller, context),

                const SizedBox(
                  height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                ),

                //Text file tính toán bảng lương
                const Padding(
                  padding: EdgeInsets.all(
                    Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  child: Text(
                    'File tính toán bảng lương:',
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                //Button Xem
                _btnXem(),
              ],
            );
          }),
    );
  }

  ///
  /// Chọn thời gian xem lương
  ///
  Widget _timeSalary(V4SalaryController controller, BuildContext context) {
    return InputWidget(
      paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      isDate: true,
      allowEdit: false,
      isColorFieldWhite: true,
      label: "Xin vui lòng chọn thời gian",
      obligatory: true,
      width: DeviceUtils.getScaledWidth(context, 1),
      textEditingController: controller.salaryController,
      suffixIcon: const Icon(
        Icons.date_range,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
    );
  }

  ///
  ///Button xem
  ///
  Widget _btnXem() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: LongButton(
        color: ColorResources.PRIMARY,
        onPressed: () {},
        title: 'Xem',
      ),
    );
  }
}
