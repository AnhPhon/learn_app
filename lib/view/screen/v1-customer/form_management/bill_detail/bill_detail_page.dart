import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/row_text.dart';
import 'package:template/view/screen/v1-customer/form_management/bill_detail/bill_detail_controller.dart';

class V1BillDetailPage extends GetView<V1BillDetailController> {
  ///
  ///build
  ///
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1BillDetailController>(
        init: V1BillDetailController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                //bill detail
                _containerBill(context, controller),
              ],
            ),
            bottomNavigationBar: _bottomSheet(context, controller),
          );
        });
  }

  ///
  ///note
  ///
  Widget _note(BuildContext context, V1BillDetailController controller) {
    return Padding(
        padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.025)),
        child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
                text: controller.note,
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    color: ColorResources.BLACK.withOpacity(.7),
                    height: 1.5),
                children: [
                  TextSpan(
                      text: controller.deposit,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorResources.RED,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                ])));
  }

  ///
  /// container bill
  ///
  Widget _containerBill(
      BuildContext context, V1BillDetailController controller) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: DeviceUtils.getScaledWidth(context, 0.025),
        vertical: DeviceUtils.getScaledHeight(context, 0.019),
      ),
      padding: EdgeInsets.symmetric(
        vertical: DeviceUtils.getScaledHeight(context, 0.025),
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          //price
          const RowText(text1: "Giá trị đơn hàng", text2: "11.000.000 VND"),
          const RowText(text1: "Phí dịch vụ App", text2: "50.000 VND"),
          const RowText(text1: "Khuyến mãi của App", text2: "0 VND"),
          const RowText(
              text1: "Tổng tiền đơn hàng",
              text2: "11.050.000 VND",
              colorRed: true),

          //divider
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: DeviceUtils.getScaledWidth(context, 0.025),
            ),
            child: const Divider(color: Colors.grey),
          ),

          //note
          _note(context, controller),
        ],
      ),
    );
  }

  ///
  ///bottom sheet
  ///
  Widget _bottomSheet(BuildContext context, V1BillDetailController controller) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, 0.19),
      padding: EdgeInsets.only(
        left: DeviceUtils.getScaledWidth(context, 0.038),
        right: DeviceUtils.getScaledWidth(context, 0.038),
        top: DeviceUtils.getScaledHeight(context, 0.035),
        bottom: DeviceUtils.getScaledHeight(context, 0.026),
      ),
      decoration: const BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, -2)),
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
            color: ColorResources.BLACK,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            fontWeight: FontWeight.bold),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const RowText(
                text1: "Cần thanh toán",
                text2: "11.050.000 VND",
                colorRed: true),
            BtnCustom(
              color: ColorResources.PRIMARY,
              text: "Tiếp tục",
              onTap: () => controller.onContinueClick(),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
