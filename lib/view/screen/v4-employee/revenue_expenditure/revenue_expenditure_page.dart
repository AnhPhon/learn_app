import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';

import 'package:template/view/screen/v4-employee/revenue_expenditure/revenue_expenditure_controller.dart';

class V4RevenueExpenditurePage extends GetView<V4RevenueExpenditureController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Thêm thu chi"),
      body: GetBuilder(
          init: V4RevenueExpenditureController(),
          builder: (V4RevenueExpenditureController controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      //chọn thời gian thêm thu/chi
                      _timeRevenueExpenditure(controller, context),

                      //thu hoặc chi
                      if (controller.isRevenue == true)
                        _revenue(controller, context)
                      else
                        _expenditure(controller, context),
                    ],
                  ),

                  //nội dung thu/chi
                  if (controller.isRevenue == true)
                    _contentRevenue(controller, context)
                  else
                    _contentExpenditure(controller, context),

                  //số tiền
                  _money(controller, context),

                  //Nội dung thu/chi chi tiết
                  if (controller.isRevenue == true)
                    _detailContentRevenue(controller, context)
                  else
                    _detailContentExpenditure(controller, context),

                  Container(
                    height: DeviceUtils.getScaledHeight(context, 0.05),
                  ),

                  //button thêm
                  _btnAdd(),
                ],
              ),
            );
          }),
    );
  }

  ///
  /// Chọn thời gian thu chi
  ///
  Widget _timeRevenueExpenditure(
      V4RevenueExpenditureController controller, BuildContext context) {
    return TextFieldDate(
      paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      isDate: true,
      allowEdit: true,
      controller: controller.timeRevenueExpenditure,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      holdplacer: "12-11-2021",
      label: "Ngày",
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 0.5),
    );
  }

  ///
  /// Thu  được chọn theo ở trang chủ
  ///
  Widget _revenue(
      V4RevenueExpenditureController controller, BuildContext context) {
    return InputField(
      boldHinText: true,
      allowEdit: false,
      allowMultiline: false,
      controller: controller.revenueController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      hidden: false,
      holdplacer: 'Thu',
      label: 'Loại thu',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 0.5),
    );
  }

  ///
  ///  Chi được chọn theo ở trang chủ
  ///
  Widget _expenditure(
      V4RevenueExpenditureController controller, BuildContext context) {
    return InputField(
      allowEdit: false,
      allowMultiline: false,
      controller: controller.expenditureController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      hidden: false,
      holdplacer: 'Chi',
      label: 'Loại chi',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 0.5),
    );
  }
}

///
/// Nội dung thu chính
///

Widget _contentRevenue(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputField(
    // ignore: avoid_redundant_argument_values
    line: 5,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.contentRevenueController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: 'Nhập nội dung thu chính',
    label: 'Nội dung thu chính',
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Nội dung chi chính
///
Widget _contentExpenditure(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputField(
    // ignore: avoid_redundant_argument_values
    line: 5,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.contentRevenueController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: 'Nhập nội dung chi chính',
    label: 'Nội dung chi chính',
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Số tiền
///
Widget _money(V4RevenueExpenditureController controller, BuildContext context) {
  return InputField(
    allowEdit: true,
    allowMultiline: false,
    controller: controller.moneyController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: 'Nhập số tiền',
    label: 'Số tiền',
    obligatory: true,
    typeInput: TextInputType.number,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Nội dung thu chi tiết
///

Widget _detailContentRevenue(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputField(
    // ignore: avoid_redundant_argument_values
    line: 5,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.detailContentRevenueController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: 'Nhập nội dung thu chi tiết',
    label: 'Nội dung thu chi tiết',
    obligatory: true,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Nội dung chi chi tiết
///

Widget _detailContentExpenditure(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputField(
    // ignore: avoid_redundant_argument_values
    line: 5,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.detailContentExpenditureController,
    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
    hidden: false,
    holdplacer: 'Nhập nội dung chi chi tiết',
    label: 'Nội dung chi chi tiết',
    obligatory: true,
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
