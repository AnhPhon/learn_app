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
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //thu hoặc chi
                  if (controller.isRevenue == true)
                    _revenue(controller, context)
                  else
                    _expenditure(controller, context),

                  //chọn thời gian thêm thu/chi
                  Padding(
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: _timeRevenueExpenditure(controller, context),
                  ),

                  //nội dung thu/chi
                  if (controller.isRevenue == true)
                    _contentRevenue(controller, context)
                  else
                    _contentExpenditure(controller, context),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_LARGE,
                  ),

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
                  if (controller.isRevenue == true)
                    _btnAddThu(controller)
                  else
                    _btnAddChi(controller),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                ],
              ),
            );
          }),
    );
  }

  ///
  /// Thu  được chọn theo ở trang chủ
  ///
  Widget _revenue(
      V4RevenueExpenditureController controller, BuildContext context) {
    return InputField(
      isColorFieldWhite: true,
      allowEdit: false,
      allowMultiline: false,
      controller: controller.revenueController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      hidden: false,
      holdplacer: 'Thu',
      label: 'Loại thêm',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }

  ///
  ///  Chi được chọn theo ở trang chủ
  ///
  Widget _expenditure(
      V4RevenueExpenditureController controller, BuildContext context) {
    return InputField(
      isColorFieldWhite: true,
      allowEdit: false,
      allowMultiline: false,
      controller: controller.expenditureController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      hidden: false,
      holdplacer: 'Chi',
      label: 'Loại thêm',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }
}

///
/// Chọn thời gian thu chi
///
Widget _timeRevenueExpenditure(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputWidget(
    isColorFieldWhite: true,
    isddMMyyyy: true,
    paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
    isDate: true,
    allowEdit: false,
    label: "Thời gian",
    obligatory: true,
    width: DeviceUtils.getScaledWidth(context, 1),
    textEditingController: controller.timeRevenueExpenditure,
    hintText: controller.timeNow,
    suffixIcon: const Icon(
      Icons.date_range,
      size: Dimensions.ICON_SIZE_SMALL,
      color: ColorResources.PRIMARYCOLOR,
    ),
  );
}

///
/// Nội dung thu chính
///

Widget _contentRevenue(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputField(
    line: 7,
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
    line: 7,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.contentExpenditureController,
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
  return InputWidget(
    isColorFieldWhite: true,
    labelBold: true,
    thousandsSeparator: true,
    textInputType: TextInputType.number,
    hintText: "Vui lòng nhập số tiền",
    label: 'Số tiền',
    obligatory: true,
    width: DeviceUtils.getScaledWidth(context, 1),
    textEditingController: controller.moneyController,
  );
}

///
/// Nội dung thu chi tiết
///

Widget _detailContentRevenue(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputField(
    line: 7,
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
    line: 7,
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
Widget _btnAddThu(V4RevenueExpenditureController controller) {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {
      controller.onAddThu();
    },
    title: 'Thêm thu',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}

///
/// Button Chi
///
Widget _btnAddChi(V4RevenueExpenditureController controller) {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {
      controller.onAddChi();
    },
    title: 'Thêm chi',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}
