import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/screen/v4-employee/revenue_expenditure/revenue_expenditure_controller.dart';

class V4RevenueExpenditurePage extends GetView<V4RevenueExpenditureController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V4RevenueExpenditureController>(
      init: V4RevenueExpenditureController(),
      builder: (V4RevenueExpenditureController controller) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Scaffold(
                appBar: const AppBarWidget(title: "Thêm thu chi"),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),

                      //thu hoặc chi
                      if (controller.isRevenue == true)
                        _revenue(controller, context)
                      else
                        _expenditure(controller, context),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //chọn thời gian thêm thu/chi
                      _timeRevenueExpenditure(controller, context),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //nội dung thu/chi
                      if (controller.isRevenue == true)
                        _contentRevenue(controller, context)
                      else
                        _contentExpenditure(controller, context),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //số tiền
                      _money(controller, context),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

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
                )),
          ),
        );
      },
    );
  }

  ///
  /// Thu  được chọn theo ở trang chủ
  ///
  Widget _revenue(
      V4RevenueExpenditureController controller, BuildContext context) {
    return InputWidget(
      labelBold: true,
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      fillColor: ColorResources.LIGHT_GREY.withOpacity(0.8),
      allowEdit: false,
      label: 'Loại thêm',
      obligatory: true,
      width: DeviceUtils.getScaledWidth(context, 1),
      textEditingController: controller.revenueController,
    );
  }

  ///
  ///  Chi được chọn theo ở trang chủ
  ///
  Widget _expenditure(
      V4RevenueExpenditureController controller, BuildContext context) {
    return InputWidget(
      labelBold: true,
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      fillColor: ColorResources.LIGHT_GREY.withOpacity(0.8),
      allowEdit: false,
      label: 'Loại thêm',
      obligatory: true,
      width: DeviceUtils.getScaledWidth(context, 1),
      textEditingController: controller.expenditureController,
    );
  }
}

///
/// Chọn thời gian thu chi
///
Widget _timeRevenueExpenditure(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputWidget(
    labelBold: true,
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
    isddMMyyyy: true,
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
  return InputWidget(
    labelBold: true,
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
    hintText: "Vui lòng nhập nội dung thu chính",
    label: 'Nội dung thu chính',
    obligatory: true,
    width: DeviceUtils.getScaledWidth(context, 1),
    textEditingController: controller.contentRevenueController,
  );
}

///
/// Nội dung chi chính
///
Widget _contentExpenditure(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputWidget(
    labelBold: true,
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
    hintText: "Vui lòng nhập nội dung chi chính",
    label: 'Nội dung chi chính',
    obligatory: true,
    width: DeviceUtils.getScaledWidth(context, 1),
    textEditingController: controller.contentExpenditureController,
  );
}

///
/// Số tiền
///
Widget _money(V4RevenueExpenditureController controller, BuildContext context) {
  return InputWidget(
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
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
  return InputWidget(
    labelBold: true,
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
    maxLine: 8,
    hintText: "Vui lòng nhập nội dung thu chi tiết",
    label: 'Nội dung thu chi tiết',
    obligatory: true,
    width: DeviceUtils.getScaledWidth(context, 1),
    textEditingController: controller.detailContentRevenueController,
  );
}

///
/// Nội dung chi chi tiết
///

Widget _detailContentExpenditure(
    V4RevenueExpenditureController controller, BuildContext context) {
  return InputWidget(
    labelBold: true,
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
    maxLine: 8,
    hintText: "Vui lòng nhập nội dung chi chi tiết",
    label: 'Nội dung chi chi tiết',
    obligatory: true,
    width: DeviceUtils.getScaledWidth(context, 1),
    textEditingController: controller.detailContentExpenditureController,
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
